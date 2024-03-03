{ pkgs, ... }: {
  home.packages = with pkgs.gnomeExtensions; [
    appindicator
    bluetooth-battery
    caffeine
    gsconnect
    just-perfection
    pano
    rounded-window-corners
    vitals
  ];
}
