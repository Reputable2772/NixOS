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
      "float, initialClass:com.github.hluk.copyq"
      "float, initialClass:com.github.hluk.copyq"
      "opaque, initialClass:com.github.hluk.copyq"
      "dimaround, initialClass:com.github.hluk.copyq"
      "stayfocused, initialClass:com.github.hluk.copyq"
    ];
  };
}
