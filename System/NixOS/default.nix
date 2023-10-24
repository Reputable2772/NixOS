{ pkgs, config, lib, ... }: {
  imports = [
    ./Hardware
    ./Services
    ./boot.nix
    ./configuration.nix
    ./gnome.nix
    ./networking.nix
    ./packages.nix
    ./sudo.nix
    ./virtualisation.nix
  ];
}