{ config, lib, ... }:
{
  # Don't wait for online.
  systemd.services.NetworkManager-wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
  systemd.network.wait-online.enable = false;

  /**
    Look at the crowdsec container for more info.
  */
  services.crowdsec-firewall-bouncer = {
    enable = true;
    settings.api_url = "http://127.0.0.1:8008";
    secrets.apiKeyPath = config.age.secrets.crowdsec-firewall-bouncer.path;
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
