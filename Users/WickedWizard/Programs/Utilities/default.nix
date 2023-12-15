{ config, pkgs, ... }: {
  imports = [
    ./alien.nix
    ./kitty.nix
    ./nom.nix
    ./protonvpn.nix
    ./power-manager.nix
  ];
}
