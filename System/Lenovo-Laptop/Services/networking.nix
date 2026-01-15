{ config, lib, ... }:
{
  # Don't wait for online.
  systemd.services.NetworkManager-wait-online.enable = false;

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
