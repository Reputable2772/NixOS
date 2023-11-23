{ config, pkgs, ... }: {
  imports = [
    ./kitty.nix
    ./protonvpn.nix
    ./power-manager.nix
  ];
}
