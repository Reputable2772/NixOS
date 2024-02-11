{ config, pkgs, ... }: {
  imports = [
    ./calibre.nix
    # ./kodi.nix
    ./obs-studio.nix
    ./spotube.nix
    ./vlc.nix
  ];
}
