{ pkgs, lib, ... }: {
  services.xserver.enable = lib.mkDefault false;
  services.xserver.desktopManager.gnome.enable = false;
  services.xserver.displayManager.gdm.enable = false;

  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-console
    gnome-calculator
    gnome-tour
    cheese
    gnome-music
    geary
    gnome-software
    totem
    tali
    iagno
    hitori
    atomix
    simple-scan
  ];
}
