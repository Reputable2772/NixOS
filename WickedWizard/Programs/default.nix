{ config, pkgs, ... }: {
  imports = [
    ./Browsers
    ./Communication
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
  ];
}
