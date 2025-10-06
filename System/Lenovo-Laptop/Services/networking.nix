{ config, lib, ... }:
{
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
