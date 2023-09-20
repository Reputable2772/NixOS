{ pkgs, config, lib, ... }: {
  imports = [
    ./boot.nix
    ./bluetooth.nix
    ./environment.nix
    ./hardware.nix
    ./networking.nix
    ./Services
    ./sudo.nix
  ];
}
