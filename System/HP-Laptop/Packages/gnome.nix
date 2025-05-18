{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.xserver.enable = lib.mkDefault false;
  services.xserver.desktopManager.gnome.enable = false;
  services.xserver.displayManager.gdm.enable = config.services.xserver.desktopManager.gnome.enable;

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
