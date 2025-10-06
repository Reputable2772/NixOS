{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.xserver.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = config.services.desktopManager.gnome.enable;

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-maps
    epiphany
    snapshot
    cheese
    gnome-music
    geary
    totem
    tali
    iagno
    hitori
    atomix
    simple-scan
  ];
}
