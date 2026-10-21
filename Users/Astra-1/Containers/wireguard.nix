{
  config,
  config',
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.strings) concatMapAttrsStringSep toUpper;
  inherit (lib.attrsets)
    mapAttrs'
    mapAttrsToList
    nameValuePair
    recursiveUpdate
    ;
  inherit (lib.lists) elem;

  wg = config'.containers.wireguard;
  peers = wg.peers;

  # Forward traffic between WireGuard and containers on the Podman network (bidirectional).
  forwardPostUp = ''
    PostUp = iptables -A FORWARD -i wg0 -d ${wg.network.ipv4.subnet} -j ACCEPT
    PostUp = iptables -A FORWARD -s ${wg.network.ipv4.subnet} -o wg0 -j ACCEPT
    PostUp = ip6tables -A FORWARD -i wg0 -d ${wg.network.ipv6.subnet} -j ACCEPT
    PostUp = ip6tables -A FORWARD -s ${wg.network.ipv6.subnet} -o wg0 -j ACCEPT
  '';

  forwardPostDown = ''
    PostDown = iptables -D FORWARD -i wg0 -d ${wg.network.ipv4.subnet} -j ACCEPT
    PostDown = iptables -D FORWARD -s ${wg.network.ipv4.subnet} -o wg0 -j ACCEPT
    PostDown = ip6tables -D FORWARD -i wg0 -d ${wg.network.ipv6.subnet} -j ACCEPT
    PostDown = ip6tables -D FORWARD -s ${wg.network.ipv6.subnet} -o wg0 -j ACCEPT
  '';

  peersConfig = concatMapAttrsStringSep "\n\n" (name: peer: ''
    [Peer]
    PublicKey = @WIREGUARD_PEER_${toUpper name}_PUBLIC_KEY@
    AllowedIPs = ${peer.network.ipv4.subnet}, ${peer.network.ipv6.subnet}
  '') peers;

  peerSecretDefs = mapAttrs' (
    name: _:
    nameValuePair "WIREGUARD_PEER_${toUpper name}_PUBLIC_KEY" {
      description = "WireGuard Public Key for ${name}";
    }
  ) peers;

  peerSecretReplacements = mapAttrs' (
    name: _:
    nameValuePair "@WIREGUARD_PEER_${toUpper name}_PUBLIC_KEY@"
      config.secretspec.secrets.profiles.astra-1."WIREGUARD_PEER_${toUpper name}_PUBLIC_KEY".plainPath
  ) peers;

  mkRouteScript =
    cName:
    pkgs.writeShellScript "${cName}-wg-routes" ''
      PID=$(${pkgs.podman}/bin/podman inspect ${cName} --format '{{.State.Pid}}' 2>/dev/null || true)
      if [ -n "$PID" ] && [ "$PID" -gt 0 ] 2>/dev/null; then
        for i in {1..5}; do
          ${concatMapAttrsStringSep "\n" (_: peer: ''
            ${pkgs.util-linux}/bin/nsenter -t $PID -U -n --preserve-credentials ${pkgs.iproute2}/bin/ip route replace ${peer.network.ipv4.subnet} via ${wg.network.ipv4.ip} 2>/dev/null || true
            ${pkgs.util-linux}/bin/nsenter -t $PID -U -n --preserve-credentials ${pkgs.iproute2}/bin/ip -6 route replace ${peer.network.ipv6.subnet} via ${wg.network.ipv6.ip} 2>/dev/null || true
          '') peers}
          exit 0
        done
      fi
      exit 0
    '';

  corefile = pkgs.writeText "coredns-corefile" ''
    ${concatMapAttrsStringSep "\n" (_: peer: ''
      # Zone for ${peer.network.domain} peer domain
      ${peer.network.domain}:53 {
          log
          errors
          rewrite stop {
              name regex ^(.*)\.${peer.network.domain}\.$ {1}.
              answer name ^(.*)\.$ {1}.${peer.network.domain}.
          }
          forward . ${peer.network.ipv4.gateway}:53 [${peer.network.ipv6.gateway}]:53
          cache 30
          loop
      }
    '') peers}

    # Zone for local ${wg.network.domain} domain
    ${wg.network.domain}:53 {
        log
        errors
        rewrite stop {
            name regex ^(.*)\.${wg.network.domain}\.$ {1}.
            answer name ^(.*)\.$ {1}.${wg.network.domain}.
        }
        forward . ${wg.network.ipv4.gateway}:53 [${wg.network.ipv6.gateway}]:53
        cache 30
        loop
    }

    # Root zone for internet queries and fallback
    .:53 {
        log
        errors
        forward . 1.1.1.1 9.9.9.9 1.0.0.1 149.112.112.112 2606:4700:4700::1111 2620:fe::fe
        cache 30
        loop
    }
  '';
in
{
  secretspec.config.profiles.astra-1 = {
    WIREGUARD_PRIVATE_KEY.description = "WG Private Key for Astra-1";
  }
  // peerSecretDefs;

  secretspec.runtimeSecretReplacements."${config.xdg.configHome}/wireguard/wg0.conf" = {
    "@WIREGUARD_PRIVATE_KEY@" =
      config.secretspec.secrets.profiles.astra-1.WIREGUARD_PRIVATE_KEY.plainPath;
  }
  // peerSecretReplacements;

  system-config.firewall.allowedUDPPorts = [ wg.listen.externalPort ];

  xdg.configFile."wireguard/wg0.conf".text = ''
    [Interface]
    Address = ${wg.network.ipv4.ip}/32, ${wg.network.ipv6.ip}/128
    ListenPort = ${toString wg.listen.port}
    PrivateKey = @WIREGUARD_PRIVATE_KEY@

    ${forwardPostUp}
    # Masquerade all inbound WireGuard traffic forwarded to local workloads.
    PostUp = iptables -t nat -A POSTROUTING -d ${wg.network.ipv4.subnet} -j MASQUERADE
    PostUp = ip6tables -t nat -A POSTROUTING -d ${wg.network.ipv6.subnet} -j MASQUERADE

    ${forwardPostDown}
    PostDown = iptables -t nat -D POSTROUTING -d ${wg.network.ipv4.subnet} -j MASQUERADE
    PostDown = ip6tables -t nat -D POSTROUTING -d ${wg.network.ipv6.subnet} -j MASQUERADE

    ${peersConfig}
  '';

  programs.quadlets = {
    preprocessors.wireguardRouting = {
      order = 600;
      apply =
        _name: quadlet: options: utils:
        let
          cName = quadlet.Container.ContainerName or "";
          nets = utils.convertToList (quadlet.Container.Network or null);
          isOnWg = elem "wireguard.network" nets;
          isTarget =
            utils.isContainer && isOnWg && cName != "wireguard" && (options.wireguardRouting or true);

          routeScript = mkRouteScript cName;

          existingPost = utils.convertToList (quadlet.Service.ExecStartPost or null);
          existingSearch = utils.convertToList (quadlet.Container.DNSSearch or null);
          peerDomains = mapAttrsToList (_: peer: peer.network.domain) peers;
        in
        if !isTarget then
          quadlet
        else
          recursiveUpdate quadlet {
            Container = {
              DNSSearch = existingSearch ++ [ "dns.podman" ] ++ peerDomains;
            };
            Service = {
              ExecStartPost = existingPost ++ [ "${routeScript}" ];
            };
          };
    };

    quadlets = {
      "coredns.container" = {
        Container = {
          ContainerName = "coredns";
          Image = "docker.io/coredns/coredns:latest";
          IP = wg.dns.ip;
          IP6 = wg.dns.ipv6;
          Network = [
            "wireguard.network"
          ];
          Volume = [
            "${corefile}:/etc/coredns/Corefile:ro:noMap"
            "${corefile}:/Corefile:ro:noMap"
          ];
          Exec = "-conf /etc/coredns/Corefile";
        };
        Unit = {
          After = [ "wireguard-network.service" ];
          Requires = [ "wireguard-network.service" ];
        };
      };
      "wireguard.container" = {
        Container = {
          ContainerName = "wireguard";
          Image = "docker.io/procustodibus/wireguard";
          IP = wg.network.ipv4.ip;
          IP6 = wg.network.ipv6.ip;
          AddCapability = [
            "NET_ADMIN"
            "NET_RAW"
          ];
          Sysctl = [
            "net.ipv4.conf.all.forwarding=1"
            "net.ipv6.conf.all.forwarding=1"
          ];
          Network = [
            "wireguard.network"
          ];
          PublishPort = [
            "${toString wg.listen.externalPort}:${toString wg.listen.port}/udp"
          ];
          Volume = [
            "${config.xdg.configHome}/wireguard/wg0.conf:/etc/wireguard/wg0.conf:ro:noMap"
          ];
        };
        Unit = {
          Wants = [ "secretspec.service" ];
          After = [ "secretspec.service" ];
        };
      };
      "wireguard.network" = {
        Network = {
          NetworkName = "wireguard";
          IPv6 = true;
          Gateway = [
            wg.network.ipv4.gateway
            wg.network.ipv6.gateway
          ];
          Subnet = [
            wg.network.ipv4.subnet
            wg.network.ipv6.subnet
          ];
          DNS = [
            wg.dns.ipv6
            wg.dns.ip
          ];
        };
      };
    };
  };
}
