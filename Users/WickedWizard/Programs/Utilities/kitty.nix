{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
      mode = "no-cursor";
    };
    font = {
      name = "SauceCodePro Nerd Font";
      size = 14;
    };
    keybindings = {
      "ctrl+alt+c" = "copy_ansi_to_clipboard";
    };
    theme = "Catppuccin-Mocha";
    settings = {
      update_check_interval = 0;
      hide_window_decorations = "yes";
      cursor_shape = "underline";
      window_padding_width = 10;
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      allow_remote_control = true;
    };
  };

  programs.autostart.files = [ "${pkgs.kitty}/share/applications/kitty.desktop" ];

  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, Return, exec, kitty"
  ];
}
