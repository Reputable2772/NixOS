{ config, pkgs, ... }: {
  home.packages = with pkgs.gnomeExtensions; [
    appindicator
    bluetooth-battery
    caffeine
    clipboard-indicator
    custom-accent-colors
    gamemode
    gsconnect
    just-perfection
    rounded-window-corners
    vitals
  ];
}
