{ pkgs, ... }: {
  services.xserver.enable = false;
  services.xserver.desktopManager.gnome.enable = false;
  services.xserver.displayManager.gdm.enable = false;

  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-console
    gnome-calculator
    gnome-tour
    gnome-maps
    epiphany
    snapshot
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
