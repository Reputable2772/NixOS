{ config, pkgs, ... }: {
  imports = [
    ./Gnome
    ./qt.nix
    ./gtk.nix
  ];
}
