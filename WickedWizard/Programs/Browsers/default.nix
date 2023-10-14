{ config, pkgs, ... }: {
  imports = [
    ./firefox.nix
    ./librewolf.nix
    ./brave.nix
    ./chromium.nix
    ./tor.nix
    ./mullvad.nix
  ];
}
