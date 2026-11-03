{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = lib.optional config.wayland.windowManager.hyprland.enable pkgs.hyprpicker;

  wayland.windowManager.hyprland.settings = {
    bind = [
      {
        _args = [
          "SUPER + X"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.hyprpicker} --autocopy")'')
        ];
      }
    ];
  };
}
