{ config, pkgs, ... }: {
  imports = [
    ./firefox.nix
    ./librewolf.nix
    ./brave.nix
    ./tor.nix
    ./mullvad.nix
  ];
}
