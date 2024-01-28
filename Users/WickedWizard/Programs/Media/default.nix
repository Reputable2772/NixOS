{ config, pkgs, ... }: {
  imports = [
    ./calibre.nix
    ./obs-studio.nix
    ./vlc.nix
    # ./kodi.nix
  ];
}
