{ config, pkgs, ... }: {
  imports = [
    ./bluetooth.nix
    ./hardware.nix
    ./gpu.nix
  ];
}
