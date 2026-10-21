{
  config,
  config',
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.attrsets) recursiveUpdate;
  inherit (lib.lists) elem;

  wg = config'.containers.wireguard;
  server = wg.server;

  mkRouteScript =
    cName:
    pkgs.writeShellScript "${cName}-wg-routes" ''
      PID=$(${pkgs.podman}/bin/podman inspect ${cName} --format '{{.State.Pid}}' 2>/dev/null || true)
      if [ -n "$PID" ] && [ "$PID" -gt 0 ] 2>/dev/null; then
        for i in {1..5}; do
          if ${pkgs.util-linux}/bin/nsenter -t $PID -U -n --preserve-credentials ${pkgs.iproute2}/bin/ip route replace ${server.network.ipv4.subnet} via ${wg.network.ipv4.ip} 2>/dev/null; then
            ${pkgs.util-linux}/bin/nsenter -t $PID -U -n --preserve-credentials ${pkgs.iproute2}/bin/ip -6 route replace ${server.network.ipv6.subnet} via ${wg.network.ipv6.ip} 2>/dev/null || true
            exit 0
          fi
          sleep 1
        done
      fi
      exit 0
    '';
in
{
  secretspec.config.profiles.wickedwizard = {
    WIREGUARD_PRIVATE_KEY.description = "WireGuard Private Key for this user.";
    WIREGUARD_PEER_ASTRA_1_PUBLIC_KEY.description = "WireGuard Public Key of Astra-1";
  };

  secretspec.runtimeSecretReplacements."${config.xdg.configHome}/wireguard/wg0.conf" = {
    "@WIREGUARD_PRIVATE_KEY@" =
      config.secretspec.secrets.profiles.wickedwizard.WIREGUARD_PRIVATE_KEY.plainPath;
    "@WIREGUARD_PEER_ASTRA_1_PUBLIC_KEY@" =
      config.secretspec.secrets.profiles.wickedwizard.WIREGUARD_PEER_ASTRA_1_PUBLIC_KEY.plainPath;
    "@BASE_DOMAIN@" = config.secretspec.secrets.profiles.wickedwizard.BASE_DOMAIN.plainPath;
  };

  xdg.configFile."wireguard/wg0.conf".text = ''
    [Interface]
    Address = ${wg.network.ipv4.ip}/32, ${wg.network.ipv6.ip}/128
    PrivateKey = @WIREGUARD_PRIVATE_KEY@

    # Forward traffic between WireGuard and client workloads (bidirectional).
    PostUp = iptables -A FORWARD -i wg0 -d ${wg.network.ipv4.subnet} -j ACCEPT
    PostUp = iptables -A FORWARD -s ${wg.network.ipv4.subnet} -o wg0 -j ACCEPT
    PostUp = ip6tables -A FORWARD -i wg0 -d ${wg.network.ipv6.subnet} -j ACCEPT
    PostUp = ip6tables -A FORWARD -s ${wg.network.ipv6.subnet} -o wg0 -j ACCEPT

    # Masquerade all inbound WireGuard traffic forwarded to local workloads.
    PostUp = iptables -t nat -A POSTROUTING -d ${wg.network.ipv4.subnet} -j MASQUERADE
    PostUp = ip6tables -t nat -A POSTROUTING -d ${wg.network.ipv6.subnet} -j MASQUERADE

    PostDown = iptables -D FORWARD -i wg0 -d ${wg.network.ipv4.subnet} -j ACCEPT
    PostDown = iptables -D FORWARD -s ${wg.network.ipv4.subnet} -o wg0 -j ACCEPT
    PostDown = ip6tables -D FORWARD -i wg0 -d ${wg.network.ipv6.subnet} -j ACCEPT
    PostDown = ip6tables -D FORWARD -s ${wg.network.ipv6.subnet} -o wg0 -j ACCEPT

    PostDown = iptables -t nat -D POSTROUTING -d ${wg.network.ipv4.subnet} -j MASQUERADE
    PostDown = ip6tables -t nat -D POSTROUTING -d ${wg.network.ipv6.subnet} -j MASQUERADE

    [Peer]
    PublicKey = @WIREGUARD_PEER_ASTRA_1_PUBLIC_KEY@
    Endpoint = ${server.listen.endpoint}
    AllowedIPs = ${server.network.ipv4.subnet}, ${server.network.ipv6.subnet}
    PersistentKeepalive = 25
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
        in
        if !isTarget then
          quadlet
        else
          recursiveUpdate quadlet {
            Container = {
              DNSSearch = existingSearch ++ [
                "dns.podman"
                server.network.domain
              ];
            };
            Service = {
              ExecStartPost = existingPost ++ [ "${routeScript}" ];
            };
          };
    };

    quadlets = {
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
            server.dns.ipv6
            server.dns.ip
          ];
        };
      };
    };
  };
}
