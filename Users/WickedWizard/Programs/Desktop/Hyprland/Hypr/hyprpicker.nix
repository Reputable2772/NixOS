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
      "SUPER, X, exec, ${lib.getExe pkgs.hyprpicker} --autocopy"
    ];
  };
}
