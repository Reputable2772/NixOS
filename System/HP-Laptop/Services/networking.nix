{ config, lib, ... }:
{
  networking = {
    firewall = config.hm-config.firewall // {
      enable = true;
    };
    hostName = "hp-laptop";
    networkmanager.connectionConfig = {
      "wifi.powersave" = lib.mkForce 2;
    };
  };
}
