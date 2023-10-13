{ config, pkgs, ... }: {
  home.packages = with pkgs.gnomeExtensions; [
    appindicator
    clipboard-indicator
    gsconnect
    bluetooth-battery
    vitals
    custom-accent-colors
    rounded-window-corners
    gamemode
    caffeine
    just-perfection
  ];
}
