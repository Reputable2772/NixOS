{ config, pkgs, ... }: {
  imports = [
    ./firefox.nix
    ./librewolf.nix
    ./tor.nix
    ./mullvad.nix
  ];
}
