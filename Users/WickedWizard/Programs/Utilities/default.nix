{ config, pkgs, ... }: {
  imports = [
    ./alien.nix
    ./kitty.nix
    ./protonvpn.nix
    ./power-manager.nix
  ];
}
