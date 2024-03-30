{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    copyq
    wl-clipboard
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${lib.getExe pkgs.copyq}"
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
