{ config, pkgs, ... }: {
  imports = [
    ./kitty.nix
    ./protonvpn.nix
    ./proton-mail.nix
    ./power-manager.nix
  ];
}
