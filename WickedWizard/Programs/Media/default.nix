{ config, pkgs, ... }: {
  imports = [
    ./easyeffects.nix
    ./obs-studio.nix
    ./vlc.nix
  ];
}
