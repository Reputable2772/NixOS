{ config, ... }:
{
  services.dunst.enable =
    config.wayland.windowManager.hyprland.enable && !config.programs.hyprpanel.enable;
  stylix.targets.dunst.enable = config.services.dunst.enable;

  wayland.windowManager.hyprland.settings = {
    bind = [
      "CTRL SUPER, N, exec, dunstctl close-all"
      "SUPER, N, exec, dunstctl history-pop"
      "CTRL SUPER, D, exec, dunstctl set-paused toggle"
    ];
  };
}
