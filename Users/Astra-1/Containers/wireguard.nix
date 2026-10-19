{ config, ... }: {
  secretspec.config.profiles.astra-1 = {
    ASTRA1_PRIVATE_KEY.description = "WG Private Key for Astra-1";
    LENOVO_PUBLIC_KEY.description = "Public Key of Lenovo";
  };

  secretspec.runtimeSecretReplacements."${config.xdg.configHome}/wireguard/wg0.conf" = {
    "@LENOVO_PUBLIC_KEY" = config.secretspec.secrets.profiles.astra-1.LENOVO_PUBLIC_KEY.plainPath;
  };

  system-config.firewall.allowedUDPPorts = [ 51235 ];

  xdg.configFile."wireguard/wg0.conf".text = ''
    [Peer]
    PublicKey = @LENOVO_PUBLIC_KEY@
    AllowedIPs = 10.85.0.2/32, 10.20.0.0/24, fdd6:61c:2978:8100::/64
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
