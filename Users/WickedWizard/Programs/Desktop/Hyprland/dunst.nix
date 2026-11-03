{ config, lib, ... }:
{
  services.dunst.enable =
    config.wayland.windowManager.hyprland.enable && !config.programs.hyprpanel.enable;
  stylix.targets.dunst.enable = config.services.dunst.enable;

  wayland.windowManager.hyprland.settings = {
    bind = [
      {
        _args = [
          "CTRL + SUPER + N"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("dunstctl close-all")'')
        ];
      }
      {
        _args = [
          "SUPER + N"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("dunstctl history-pop")'')
        ];
      }
      {
        _args = [
          "CTRL + SUPER + D"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("dunstctl set-paused toggle")'')
        ];
      }
    ];
  };
}
