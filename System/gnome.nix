{ config, pkgs, ... }: {
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-console
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    geary
    epiphany
    totem
    tali
    iagno
    hitori
    atomix
    simple-scan
  ]);
}
