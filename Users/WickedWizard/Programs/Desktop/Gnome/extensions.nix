{ config, pkgs, ... }: {
  home.packages = with pkgs.gnomeExtensions; [
    appindicator
    bluetooth-battery
    caffeine
    clipboard-indicator
    gsconnect
    just-perfection
    rounded-window-corners
    vitals
  ];
}
