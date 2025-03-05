{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wofi-emoji
    (pkgs.rofi-bluetooth.overrideAttrs (old: {
      preInstall = ''substituteInPlace ./rofi-bluetooth --replace-warn "rofi" "wofi"'';
    }))
  ];

  stylix.targets.wofi.enable = true;

  programs.wofi = {
    enable = true;

    settings = {
      allow_markup = true;
      width = 600;
      show = "drun";
      prompt = "Apps";
      normal_window = true;
      layer = "top";
      term = "foot";
      height = "305px";
      orientation = "vertical";
      halign = "fill";
      line_wrap = "off";
      dynamic_lines = false;
      allow_images = true;
      image_size = 24;
      exec_search = false;
      hide_search = false;
      parse_search = false;
      insensitive = true;
      hide_scroll = true;
      no_actions = true;
      sort_order = "default";
      gtk_dark = true;
      filter_rate = 100;
      key_expand = "Tab";
      key_exit = "Escape";
    };
  };

  programs.waybar.settings.mainBar.bluetooth.on-click = "rofi-bluetooth";

  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, A, exec, wofi"
      "SUPER, R, exec, wofi --show run"
      "SUPER, period, exec, ${pkgs.wofi-emoji}/bin/wofi-emoji"
    ];
    windowrulev2 = [
      "float, initialClass:wofi"
      "stayfocused, initialClass:wofi"
      "dimaround on, initialClass:wofi"
    ];
  };
}
