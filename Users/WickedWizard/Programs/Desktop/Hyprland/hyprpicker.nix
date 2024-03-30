{ pkgs, lib, ... }: {
  home.packages = with pkgs; [ hyprpicker ];

  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, X, exec, ${lib.getExe pkgs.hyprpicker} --autocopy"
    ];
  };
}
