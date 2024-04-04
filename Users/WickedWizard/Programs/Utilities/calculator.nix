{ pkgs, ... }: {
  home.packages = with pkgs; [ qalculate-gtk ];

  wayland.windowManager.hyprland.settings.bind = [
    ", XF86Calculator, exec, qalculate-gtk"
  ];
}
