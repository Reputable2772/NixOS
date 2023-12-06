{ config, pkgs, ... }: {
  imports = [
    ./alien.nix
    ./kitty.nix
    ./protonvpn.nix
    ./proton-mail.nix
    ./power-manager.nix
  ];
}
