{ config, pkgs, lib', ... }:
let
  catppuccin = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/dunst/main/themes/mocha.conf";
    hash = "sha256-7bejAIpueES8pwyiyY0RcMJwaFkTBf1G1RR1EhHqvig=";
  };
in
{
  services.dunst = {
    inherit (config.wayland.windowManager.hyprland) enable;
    settings = { } // lib'.iniToNix catppuccin;
  };

  wayland.windowManager.hyprland.settings = {
    bind = [
      "CTRL SUPER, N, exec, dunstctl close-all"
      "SUPER, N, exec, dunstctl history-pop"
      "CTRL SUPER, D, exec, dunstctl set-paused toggle"
    ];
  };
}
