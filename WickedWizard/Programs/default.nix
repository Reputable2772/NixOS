{ config, pkgs, ... }: {
  imports = [
    ./Browsers
    ./Communication
    ./Desktop
    ./Games
    ./Media
    ./Misc
    ./Proprietary
    ./Selfhosted
    ./Shell
    ./Utilities
  ];
}
