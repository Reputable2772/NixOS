{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = lib.optionals config.wayland.windowManager.hyprland.enable [
    pkgs.wl-clipboard
    pkgs.copyq
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      (lib.getExe config.services.copyq.package)
    ];
    bind = [
      "SUPER, C, exec, copyq toggle"
    ];
    windowrule = [
      "match:initial_class com.github.hluk.copyq, float on"
      "match:initial_class com.github.hluk.copyq, opaque on"
      "match:initial_class com.github.hluk.copyq, dim_around on"
      "match:initial_class com.github.hluk.copyq, stay_focused on"
    ];
  };
}
