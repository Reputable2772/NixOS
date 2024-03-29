{ config, pkgs, lib, ... }:
let
  hyprland = config.wayland.windowManager.hyprland;
in
{
  home.packages = lib.mkIf hyprland.enable [ pkgs.rofi-wayland ];

  home.file.rofi_theme = {
    enable = hyprland.enable;
    target = ".local/share/rofi/themes/catppuccin-mocha.rasi";
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/rofi/main/basic/.local/share/rofi/themes/catppuccin-mocha.rasi";
      hash = "sha256-xths/pnC6WKp3Twc1iqNyjxzep+CRZM47cCjAPpDTxA=";
    };
  };

  xdg.configFile.rofi = {
    enable = hyprland.enable;
    target = "rasi/config.rasi";
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/rofi/main/basic/.config/rofi/config.rasi";
      hash = "sha256-+Lyh5Cmd4wdHqx+FuJ8LV2HPpFj4JKT6wCu1xGcLpVg=";
    };
  };

  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, R, exec, rofi -show run"
      "SUPER, A, exec, rofi -show drun"
    ];
    layerrule = [
      "blur,rofi"
    ];
  };
}
