{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-console
    gnome-tour
  ]) ++ (with pkgs.gnome; [
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
  ]);

}
