{ config, pkgs, ... }: {
  imports = [
    ./obs-studio.nix
    ./vlc.nix
  ];
}
