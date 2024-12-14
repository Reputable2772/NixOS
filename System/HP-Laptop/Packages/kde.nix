{ config, lib, ... }:
{
  services.xserver.enable = lib.mkDefault false;
  services.desktopManager.plasma6.enable = false;
  services.displayManager.sddm = {
    enable = config.services.desktopManager.plasma6.enable;
    wayland = {
      enable = true;
      compositor = "kwin";
    };
    autoNumlock = true;
  };
}
