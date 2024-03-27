{ pkgs, ... }: {
  home.packages = with pkgs; [
    copyq
    wl-clipboard
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${pkgs.copyq}/bin/copyq"
    ];
    bind = [
      "SUPER, C, exec, copyq menu"
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
