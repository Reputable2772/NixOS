{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    (if config.wayland.windowManager.hyprland.enable then pkgs.qalculate-gtk else pkgs.gnome-calculator)
  ];

  wayland.windowManager.hyprland.settings.bind = [
    ", XF86Calculator, exec, qalculate-gtk"
  ];
}
