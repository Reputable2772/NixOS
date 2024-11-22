{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = lib.optional config.wayland.windowManager.hyprland.enable pkgs.qalculate-gtk;

  wayland.windowManager.hyprland.settings.bind = [
    ", XF86Calculator, exec, qalculate-gtk"
  ];
}
