{ config, pkgs, ... }: {
  programs.rofi = {
    enable = config.wayland.windowManager.hyprland.enable;
    extraConfig = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/rofi/blob/main/basic/.config/rofi/config.rasi";
      hash = "";
    };
    theme = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/rofi/main/basic/.local/share/rofi/themes/catppuccin-mocha.rasi";
      hash = "";
    };
  };
}
