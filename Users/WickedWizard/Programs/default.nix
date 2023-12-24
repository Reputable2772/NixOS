{ config, pkgs, ... }: {
  imports = [
    ./Backup
    ./Browsers
    ./Communication
    ./Compatibility
    ./Desktop
    ./Games
    ./Media
    ./Misc
    ./Productivity
    ./Programming
    ./Proprietary
    ./Selfhosted
    ./Shell
    ./Utilities

    ./android.nix
  ];
}
