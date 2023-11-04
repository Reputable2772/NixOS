{ config, pkgs, ... }: {
  imports = [
    ./kitty.nix
    ./protonvpn.nix
  ];
}
