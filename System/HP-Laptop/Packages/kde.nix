{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.xserver.enable = lib.mkDefault true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    discover
  ];
  services.displayManager.sddm = {
    enable = config.services.desktopManager.plasma6.enable;
    wayland = {
      enable = true;
      compositor = "kwin";
    };
    autoNumlock = true;
  };
}
