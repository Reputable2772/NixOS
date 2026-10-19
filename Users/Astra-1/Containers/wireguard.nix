{ config, ... }: {
  secretspec.config.profiles.astra-1 = {
    ASTRA1_PRIVATE_KEY.description = "WG Private Key for Astra-1";
    LENOVO_PUBLIC_KEY.description = "Public Key of Lenovo";
  };

  secretspec.runtimeSecretReplacements."${config.xdg.configHome}/wireguard/wg0.conf" = {
    "@LENOVO_PUBLIC_KEY@" = config.secretspec.secrets.profiles.astra-1.LENOVO_PUBLIC_KEY.plainPath;
    "@ASTRA1_PRIVATE_KEY@" = config.secretspec.secrets.profiles.astra-1.ASTRA1_PRIVATE_KEY.plainPath;
  };

  system-config.firewall.allowedUDPPorts = [ 51235 ];

  xdg.configFile."wireguard/wg0.conf".text = ''
    [Interface]
    Address = 10.85.0.1/32
    ListenPort = 51820
    PrivateKey = @ASTRA1_PRIVATE_KEY@
    # Forward client traffic to containers on the server Podman network.
    PostUp = iptables -A FORWARD -i wg0 -o eth0 -d 10.10.0.0/24 -j ACCEPT
    PostUp = iptables -A FORWARD -i eth0 -o wg0 -s 10.10.0.0/24 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

    # Masquerade client workload traffic going to the server subnet.
    PostUp = iptables -t nat -A POSTROUTING -s 10.20.0.0/24 -d 10.10.0.0/24 -o eth0 -j MASQUERADE

    # Also masquerade traffic originating from the client WireGuard tunnel IP.
    PostUp = iptables -t nat -A POSTROUTING -s 10.85.0.2/32 -d 10.10.0.0/24 -o eth0 -j MASQUERADE

    # Remove the rules when wg0 stops.
    PostDown = iptables -D FORWARD -i wg0 -o eth0 -d 10.10.0.0/24 -j ACCEPT
    PostDown = iptables -D FORWARD -i eth0 -o wg0 -s 10.10.0.0/24 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

    PostDown = iptables -t nat -D POSTROUTING -s 10.20.0.0/24 -d 10.10.0.0/24 -o eth0 -j MASQUERADE
    PostDown = iptables -t nat -D POSTROUTING -s 10.85.0.2/32 -d 10.10.0.0/24 -o eth0 -j MASQUERADE

    [Peer]
    PublicKey = @LENOVO_PUBLIC_KEY@
    AllowedIPs = 10.85.0.2/32, 10.20.0.0/24, fdd6:61c:2978:8100::/64
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
        ];
        Network = [
          "wireguard.network"
        ];
        PublishPort = [
          "51235:51820/udp"
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
          "10.10.0.1"
          "fdd6:61c:2978:8000::1"
        ];
        Subnet = [
          "10.10.0.0/24"
          "fdd6:61c:2978:8000::/64"
        ];
      };
    };
  };
}
