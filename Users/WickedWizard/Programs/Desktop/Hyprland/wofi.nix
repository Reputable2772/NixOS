{ pkgs, lib, ... }:
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
      {
        _args = [
          "SUPER + A"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wofi")'')
        ];
      }
      {
        _args = [
          "SUPER + R"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wofi --show run")'')
        ];
      }
      {
        _args = [
          "SUPER + period"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.wofi-emoji}/bin/wofi-emoji")'')
        ];
      }
    ];
    window_rule = [
      {
        match = {
          initial_class = "wofi";
        };
        float = true;
        stay_focused = true;
        dim_around = true;
      }
    ];
  };

  programs.hyprpanel.settings = {
    "menus.dashboard.shortcuts.left.shortcut4.command" = "wofi";
    "menus.dashboard.shortcuts.left.shortcut4.icon" = "";
    "menus.dashboard.shortcuts.left.shortcut4.tooltip" = "Search Apps";
  };
}
