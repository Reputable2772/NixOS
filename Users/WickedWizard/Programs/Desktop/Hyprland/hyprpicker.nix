{ config, pkgs, ... }: {
  home.packages = with pkgs; [ hyprpicker ];

  # Fixes https://github.com/hyprwm/hyprpicker/issues/51
  home.pointerCursor = {
    gtk.enable = config.gtk.enable;
    package = config.gtk.iconTheme.package;
    name = config.gtk.iconTheme.name;
  };
}
