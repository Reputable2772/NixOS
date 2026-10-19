{ config, ... }: {
  secretspec.config.profiles.wickedwizard = {
    LENOVO_WG_PRIVATE_KEY.description = "WG Private Key for Lenovo";
    ASTRA1_PUBLIC_KEY.description = "Public Key of Astra-1";
  };

  secretspec.runtimeSecretReplacements."${config.xdg.configHome}/wireguard/wg0.conf" = {
    "@LENOVO_WG_PRIVATE_KEY@" =
      config.secretspec.secrets.profiles.wickedwizard.LENOVO_WG_PRIVATE_KEY.plainPath;
    "@ASTRA1_PUBLIC_KEY@" = config.secretspec.secrets.profiles.wickedwizard.ASTRA1_PUBLIC_KEY.plainPath;
    "@ASTRA1_DOMAIN@" = config.secretspec.secrets.profiles.wickedwizard.BASE_DOMAIN.plainPath;
  };

  xdg.configFile."wireguard/wg0.conf".text = ''
    [Interface]
    Address = 10.85.0.2/32
    ListenPort = 51235
    PrivateKey = @LENOVO_WG_PRIVATE_KEY@
    # Forward traffic arriving through the tunnel to client workloads.
    # IPv4 SNAT makes replies from local workloads return through this
    # WireGuard container, without requiring a route on the Podman host.
    PostUp = iptables -A FORWARD -i wg0 -o eth0 -s 10.10.0.0/24 -d 10.20.0.0/24 -j ACCEPT
    PostUp = iptables -A FORWARD -i eth0 -o wg0 -s 10.20.0.0/24 -d 10.10.0.0/24 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
    PostUp = iptables -t nat -A POSTROUTING -s 10.10.0.0/24 -d 10.20.0.0/24 -o eth0 -j MASQUERADE

    PostDown = iptables -D FORWARD -i wg0 -o eth0 -s 10.10.0.0/24 -d 10.20.0.0/24 -j ACCEPT
    PostDown = iptables -D FORWARD -i eth0 -o wg0 -s 10.20.0.0/24 -d 10.10.0.0/24 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
    PostDown = iptables -t nat -D POSTROUTING -s 10.10.0.0/24 -d 10.20.0.0/24 -o eth0 -j MASQUERADE

    [Peer]
    PublicKey = @ASTRA1_PUBLIC_KEY@
    Endpoint = astra.@ASTRA1_DOMAIN@:51235
    AllowedIPs = 10.85.0.2/32
    PersistentKeepalive = 25
  '';

  programs.quadlets.quadlets = {
    "wireguard.container" = {
      Container = {
        ContainerName = "wireguard";
        Image = "docker.io/procustodibus/wireguard";
        AddCapability = [ "NET_ADMIN" ];
        Network = [
          "wireguard.network"
        ];
        Volume = [
          "${config.xdg.configHome}/wireguard/wg0.conf:/etc/wireguard:ro"
        ];
      };
    };
    "wireguard.network" = {
      Network = {
        NetworkName = "wireguard";
        IPv6 = true;
        Gateway = [
          "10.20.0.1"
          "fdd6:61c:2978:8100::1"
        ];
        Subnet = [
          "10.20.0.0/24"
          "fdd6:61c:2978:8100::/64"
        ];
      };
    };
  };
}
