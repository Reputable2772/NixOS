{ config, sources, pkgs, lib, ... }:
let
  inherit (config.wayland.windowManager) hyprland;
in
{
  home.packages = lib.mkIf hyprland.enable [ pkgs.rofi-wayland ];

  xdg.configFile.rofi = {
    inherit (hyprland) enable;
    target = "rasi/config.rasi";
    source = "${sources.rofi_catppuccin.src}/basic/.config/rofi/config.rasi";
  };

  home.file = {
    rofi_theme = {
      inherit (hyprland) enable;
      target = ".local/share/rofi/themes/catppuccin-mocha.rasi";
      source = "${sources.rofi_catppuccin.src}/basic/.local/share/rofi/themes/catppuccin-mocha.rasi";
    };
    rofi_bluetooth = {
      inherit (hyprland) enable;
      target = ".local/bin/rofi-bluetooth";
      source = "${sources.rofi-bluetooth.src}/rofi-bluetooth";
      executable = true;
    };
  };

  programs.waybar.settings.mainBar.bluetooth.on-click = "rofi-bluetooth";

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
