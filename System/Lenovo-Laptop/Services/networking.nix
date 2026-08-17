{ config, lib, ... }:
{
  # Don't wait for online.
  systemd.services.NetworkManager-wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
  systemd.network.wait-online.enable = false;

  secretspec.config.profiles.lenovo-laptop.CROWDSEC_FIREWALL_BOUNCER.description =
    "API Key for Crowdsec Firewall bouncer";

  /**
    Look at the crowdsec container for more info.
  */
  services.crowdsec-firewall-bouncer = {
    enable = true;
    settings.api_url = "http://127.0.0.1:8008";
    secrets.apiKeyPath =
      config.secretspec.secrets.profiles.lenovo-laptop.CROWDSEC_FIREWALL_BOUNCER.plainPath;
  };

  networking = {
    firewall = config.hm-config.firewall // {
      enable = true;
    };
    hostName = "lenovo-laptop";
    networkmanager.connectionConfig = {
      "wifi.powersave" = lib.mkForce 3;
    };
  };
}
