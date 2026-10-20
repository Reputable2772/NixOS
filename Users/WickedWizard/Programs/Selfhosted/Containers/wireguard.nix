{ config, config', ... }:
let
  wg = config'.containers.wireguard;
  server = wg.server;
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
    Address = ${wg.network.tunnel.ipv4}/32, ${wg.network.tunnel.ipv6}/128
    PrivateKey = @WIREGUARD_PRIVATE_KEY@
    # Forward traffic between WireGuard and client workloads (bidirectional).
    PostUp = iptables -A FORWARD -i wg0 -d ${wg.network.containers.ipv4.subnet} -j ACCEPT
    PostUp = iptables -A FORWARD -s ${wg.network.containers.ipv4.subnet} -o wg0 -j ACCEPT
    PostUp = ip6tables -A FORWARD -i wg0 -d ${wg.network.containers.ipv6.subnet} -j ACCEPT
    PostUp = ip6tables -A FORWARD -s ${wg.network.containers.ipv6.subnet} -o wg0 -j ACCEPT

    # Masquerade traffic originating from server workloads.
    PostUp = iptables -t nat -A POSTROUTING -s ${server.network.containers.ipv4.subnet} -d ${wg.network.containers.ipv4.subnet} -j MASQUERADE
    PostUp = ip6tables -t nat -A POSTROUTING -s ${server.network.containers.ipv6.subnet} -d ${wg.network.containers.ipv6.subnet} -j MASQUERADE

    # Also handle traffic originating from the server's tunnel address.
    PostUp = iptables -t nat -A POSTROUTING -s ${server.network.tunnel.ipv4}/32 -d ${wg.network.containers.ipv4.subnet} -j MASQUERADE
    PostUp = ip6tables -t nat -A POSTROUTING -s ${server.network.tunnel.ipv6}/128 -d ${wg.network.containers.ipv6.subnet} -j MASQUERADE

    PostDown = iptables -D FORWARD -i wg0 -d ${wg.network.containers.ipv4.subnet} -j ACCEPT
    PostDown = iptables -D FORWARD -s ${wg.network.containers.ipv4.subnet} -o wg0 -j ACCEPT
    PostDown = ip6tables -D FORWARD -i wg0 -d ${wg.network.containers.ipv6.subnet} -j ACCEPT
    PostDown = ip6tables -D FORWARD -s ${wg.network.containers.ipv6.subnet} -o wg0 -j ACCEPT

    PostDown = iptables -t nat -D POSTROUTING -s ${server.network.containers.ipv4.subnet} -d ${wg.network.containers.ipv4.subnet} -j MASQUERADE
    PostDown = ip6tables -t nat -D POSTROUTING -s ${server.network.containers.ipv6.subnet} -d ${wg.network.containers.ipv6.subnet} -j MASQUERADE
    PostDown = iptables -t nat -D POSTROUTING -s ${server.network.tunnel.ipv4}/32 -d ${wg.network.containers.ipv4.subnet} -j MASQUERADE
    PostDown = ip6tables -t nat -D POSTROUTING -s ${server.network.tunnel.ipv6}/128 -d ${wg.network.containers.ipv6.subnet} -j MASQUERADE

    [Peer]
    PublicKey = @WIREGUARD_PEER_ASTRA_1_PUBLIC_KEY@
    Endpoint = ${server.listen.endpoint}
    AllowedIPs = ${server.network.tunnel.ipv4}/32, ${server.network.tunnel.ipv6}/128, ${server.network.containers.ipv4.subnet}, ${server.network.containers.ipv6.subnet}
    PersistentKeepalive = 25
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
        DNS = [ server.network.containers.ipv4.gateway ];
      };
    };
  };
}
