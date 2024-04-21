{ config, pkgs, lib, ... }:
let
  inherit (config.wayland.windowManager) hyprland;
in
{
  home.packages = lib.mkIf hyprland.enable [ pkgs.rofi-wayland ];

  xdg.configFile.rofi = {
    inherit (hyprland) enable;
    target = "rasi/config.rasi";
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/rofi/main/basic/.config/rofi/config.rasi";
      hash = "sha256-+Lyh5Cmd4wdHqx+FuJ8LV2HPpFj4JKT6wCu1xGcLpVg=";
    };
  };

  home.file = {
    rofi_theme = {
      inherit (hyprland) enable;
      target = ".local/share/rofi/themes/catppuccin-mocha.rasi";
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/rofi/main/basic/.local/share/rofi/themes/catppuccin-mocha.rasi";
        hash = "sha256-xths/pnC6WKp3Twc1iqNyjxzep+CRZM47cCjAPpDTxA=";
      };
    };
    rofi_bluetooth = {
      inherit (hyprland) enable;
      target = ".local/bin/rofi-bluetooth";
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/nickclyde/rofi-bluetooth/master/rofi-bluetooth";
        hash = "sha256-s06OsedQjd5uDDCVX5h4WPLnMM/OEZzDsCxgQxGojPk=";
      };
      executable = true;
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
