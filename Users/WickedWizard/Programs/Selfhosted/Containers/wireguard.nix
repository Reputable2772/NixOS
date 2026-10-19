{ config, ... }: {
  secretspec.config.profiles.wickedwizard = {
    WG_PRIVATE_KEY.description = "WG Private Key for Lenovo";
    ASTRA1_PUBLIC_KEY.description = "Public Key of Astra-1";
  };

  secretspec.runtimeSecretReplacements."${config.xdg.configHome}/wireguard/wg0.conf" = {
    "@WG_PRIVATE_KEY@" = config.secretspec.secrets.profiles.wickedwizard.WG_PRIVATE_KEY.plainPath;
    "@ASTRA1_PUBLIC_KEY@" = config.secretspec.secrets.profiles.wickedwizard.ASTRA1_PUBLIC_KEY.plainPath;
    "@BASE_DOMAIN@" = config.secretspec.secrets.profiles.wickedwizard.BASE_DOMAIN.plainPath;
  };

  xdg.configFile."wireguard/wg0.conf".text = ''
    [Interface]
    Address = 10.85.0.2/32
    PrivateKey = @WG_PRIVATE_KEY@

    [Peer]
    PublicKey = @ASTRA1_PUBLIC_KEY@
    Endpoint = astra-1.@BASE_DOMAIN@:51235
    AllowedIPs = 10.85.0.1/32, 10.10.0.0/24, fdd6:61c:2978:8000::/64
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
