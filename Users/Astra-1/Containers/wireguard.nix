{
  config,
  config',
  lib,
  ...
}:
let
  inherit (lib.strings) concatMapAttrsStringSep toUpper;
  inherit (lib.attrsets) mapAttrs' mapAttrsToList nameValuePair;

  wg = config'.containers.wireguard;
  peers = wg.peers;

  # Forward traffic between WireGuard and containers on the Podman network (bidirectional).
  forwardPostUp = ''
    PostUp = iptables -A FORWARD -i wg0 -d ${wg.network.containers.ipv4.subnet} -j ACCEPT
    PostUp = iptables -A FORWARD -s ${wg.network.containers.ipv4.subnet} -o wg0 -j ACCEPT
    PostUp = ip6tables -A FORWARD -i wg0 -d ${wg.network.containers.ipv6.subnet} -j ACCEPT
    PostUp = ip6tables -A FORWARD -s ${wg.network.containers.ipv6.subnet} -o wg0 -j ACCEPT
  '';

  masqueradePostUp = concatMapAttrsStringSep "\n" (name: peer: ''
    # Masquerade ${name} workload traffic going to the server subnet.
    PostUp = iptables -t nat -A POSTROUTING -s ${peer.network.containers.ipv4.subnet} -d ${wg.network.containers.ipv4.subnet} -j MASQUERADE
    PostUp = ip6tables -t nat -A POSTROUTING -s ${peer.network.containers.ipv6.subnet} -d ${wg.network.containers.ipv6.subnet} -j MASQUERADE
    # Also masquerade traffic originating from the ${name} WireGuard tunnel IP.
    PostUp = iptables -t nat -A POSTROUTING -s ${peer.network.tunnel.ipv4}/32 -d ${wg.network.containers.ipv4.subnet} -j MASQUERADE
    PostUp = ip6tables -t nat -A POSTROUTING -s ${peer.network.tunnel.ipv6}/128 -d ${wg.network.containers.ipv6.subnet} -j MASQUERADE
  '') peers;

  forwardPostDown = ''
    PostDown = iptables -D FORWARD -i wg0 -d ${wg.network.containers.ipv4.subnet} -j ACCEPT
    PostDown = iptables -D FORWARD -s ${wg.network.containers.ipv4.subnet} -o wg0 -j ACCEPT
    PostDown = ip6tables -D FORWARD -i wg0 -d ${wg.network.containers.ipv6.subnet} -j ACCEPT
    PostDown = ip6tables -D FORWARD -s ${wg.network.containers.ipv6.subnet} -o wg0 -j ACCEPT
  '';

  masqueradePostDown = concatMapAttrsStringSep "\n" (name: peer: ''
    PostDown = iptables -t nat -D POSTROUTING -s ${peer.network.containers.ipv4.subnet} -d ${wg.network.containers.ipv4.subnet} -j MASQUERADE
    PostDown = ip6tables -t nat -D POSTROUTING -s ${peer.network.containers.ipv6.subnet} -d ${wg.network.containers.ipv6.subnet} -j MASQUERADE
    PostDown = iptables -t nat -D POSTROUTING -s ${peer.network.tunnel.ipv4}/32 -d ${wg.network.containers.ipv4.subnet} -j MASQUERADE
    PostDown = ip6tables -t nat -D POSTROUTING -s ${peer.network.tunnel.ipv6}/128 -d ${wg.network.containers.ipv6.subnet} -j MASQUERADE
  '') peers;

  peersConfig = concatMapAttrsStringSep "\n\n" (name: peer: ''
    [Peer]
    PublicKey = @WIREGUARD_PEER_${toUpper name}_PUBLIC_KEY@
    AllowedIPs = ${peer.network.tunnel.ipv4}/32, ${peer.network.tunnel.ipv6}/128, ${peer.network.containers.ipv4.subnet}, ${peer.network.containers.ipv6.subnet}
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
    Address = ${wg.network.tunnel.ipv4}/32, ${wg.network.tunnel.ipv6}/128
    ListenPort = ${toString wg.listen.port}
    PrivateKey = @WIREGUARD_PRIVATE_KEY@
    ${forwardPostUp}
    ${masqueradePostUp}

    ${forwardPostDown}
    ${masqueradePostDown}

    ${peersConfig}
  '';

  programs.quadlets.quadlets = {
    "wireguard.container" = {
      Container = {
        ContainerName = "wireguard";
        Image = "docker.io/procustodibus/wireguard";
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
          wg.network.containers.ipv4.gateway
          wg.network.containers.ipv6.gateway
        ];
        Subnet = [
          wg.network.containers.ipv4.subnet
          wg.network.containers.ipv6.subnet
        ];
        DNS = mapAttrsToList (_: peer: peer.network.containers.ipv4.gateway) peers;
      };
    };
  };
}
