{ config, pkgs, ... }: {
  imports = [
    ./alien.nix
    ./kitty.nix
    ./nom.nix
    ./protonvpn.nix
    ./proton-mail.nix
    ./power-manager.nix
  ];
}
