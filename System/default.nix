{ pkgs, config, lib, ... }: {
  imports = [
    ./Services
    ./boot.nix
    ./gnome.nix
    ./hardware.nix
    ./networking.nix
    ./packages.nix
    ./programs.nix
    ./sudo.nix
    ./virtualisation.nix
  ];
}
