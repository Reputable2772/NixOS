{ config, pkgs, ... }: {
  imports = [
    ./alien.nix
    ./evince.nix
    ./file-roller.nix
    ./kitty.nix
    ./protonvpn.nix
    ./power-manager.nix
    ./thunar.nix
  ];
}
