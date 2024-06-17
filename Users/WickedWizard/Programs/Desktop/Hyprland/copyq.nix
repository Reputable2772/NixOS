{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    wl-clipboard
  ];

  services.copyq = {
    enable = true;
    systemdTarget = "";
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      (lib.getExe config.services.copyq.package)
    ];
    bind = [
      "SUPER, C, exec, copyq toggle"
    ];
    windowrule = [
      "float, copyq"
    ];
    windowrulev2 = [
      "dimaround,class:^(com.github.hluk.copyq)$"
      "noborder,class:^(com.github.hluk.copyq)$"
    ];
  };
}
