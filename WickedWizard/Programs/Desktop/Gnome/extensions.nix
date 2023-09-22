{ config, pkgs, ... }: {
  home.packages = with pkgs.gnomeExtensions; [
    appindicator
    clipboard-indicator
    gsconnect
    bluetooth-battery
    gamemode
    caffeine
  ];
}
