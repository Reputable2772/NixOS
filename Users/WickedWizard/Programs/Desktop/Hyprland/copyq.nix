{ config, pkgs, lib, ... }: {
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
      "float, copyq"
      "float, .*com.github.hluk.copyq.*"
      "opaque, .*com.github.hluk.copyq.*"
      "dimaround, .*com.github.hluk.copyq.*"
      "stayfocused, .*com.github.hluk.copyq.*"
    ];
  };
}
