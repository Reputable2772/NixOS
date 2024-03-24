{ config, pkgs, lib, ... }:
let
  hyprland = config.wayland.windowManager.hyprland.enable;
in
{
  home.packages = lib.mkIf hyprland [ pkgs.rofi ];

  home.file.rofi_theme = {
    enable = hyprland;
    target = ".local/share/rofi/themes/catppuccin-mocha.rasi";
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/rofi/main/basic/.local/share/rofi/themes/catppuccin-mocha.rasi";
      hash = "sha256-xths/pnC6WKp3Twc1iqNyjxzep+CRZM47cCjAPpDTxA=";
    };
  };

  xdg.configFile.rofi = {
    enable = hyprland;
    target = "rasi/config.rasi";
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/rofi/main/basic/.config/rofi/config.rasi";
      hash = "sha256-+Lyh5Cmd4wdHqx+FuJ8LV2HPpFj4JKT6wCu1xGcLpVg=";
    };
  };
}
