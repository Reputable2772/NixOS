{ pkgs, ... }: {
  home.packages = with pkgs; [ copyq ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${pkgs.copyq}/bin/copyq"
    ];
  };
}
