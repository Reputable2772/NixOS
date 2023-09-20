{ config, pkgs, ... }: {
  imports = [
    ./firefox.nix
    ./librewolf.nix
  ];
}
