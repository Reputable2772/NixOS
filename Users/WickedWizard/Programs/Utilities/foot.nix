{ pkgs, lib', ... }:
let
  catppuccin = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/foot/main/themes/catppuccin-mocha.ini";
    hash = "sha256-Yr5/n7m3DAwQ8z4EdV9C1BTs88iMvFQ3Ah9L6Dh5hZQ=";
  };
in
{
  programs.foot = {
    enable = true;
    settings = { } // lib'.iniToNix catppuccin;
  };

  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, Return, exec, foot"
  ];
}
