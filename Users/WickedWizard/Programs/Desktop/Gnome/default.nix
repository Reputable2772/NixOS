{ config, pkgs, ... }: {
  imports = [
    ./extensions.nix
    ./gnome.nix
    ./nautilus.nix
    ./packages.nix
  ];
}