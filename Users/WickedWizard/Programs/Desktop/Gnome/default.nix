{ config, pkgs, ... }: {
  imports = [
    ./extensions.nix
    ./gnome.nix
    ./packages.nix
    ./services.nix
  ];
}
