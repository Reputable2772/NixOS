{ pkgs, ... }: {
  programs.gnome = {
    enable = false;
    excludePackages = (with pkgs; [
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
  };
}
