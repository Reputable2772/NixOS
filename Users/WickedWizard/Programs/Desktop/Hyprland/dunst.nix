{ config, sources, lib', ... }:
{
  services.dunst = {
    inherit (config.wayland.windowManager.hyprland) enable;
    settings = { } // lib'.iniToNix "${sources.dunst_catppuccin.src}/themes/mocha.conf";
  };

  wayland.windowManager.hyprland.settings = {
    bind = [
      "CTRL SUPER, N, exec, dunstctl close-all"
      "SUPER, N, exec, dunstctl history-pop"
      "CTRL SUPER, D, exec, dunstctl set-paused toggle"
    ];
  };
}
