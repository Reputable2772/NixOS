{
  osConfig,
  config,
  pkgs,
  ...
}:
{
  stylix.targets.hyprland.enable = config.wayland.windowManager.hyprland.enable;

  wayland.windowManager.hyprland = {
    inherit (osConfig.programs.hyprland) enable;

    # Use packages from system itself.
    package = null;
    portalPackage = null;

    systemd = {
      enable = !osConfig.programs.hyprland.withUWSM;
      enableXdgAutostart = true;
    };
    xwayland.enable = true;
    settings = {
      exec-once = [
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "${pkgs.systemd}/bin/systemctl --user daemon-reload"
      ];

      general = {
        layout = "dwindle";
        resize_on_border = true;
        no_border_on_floating = true;
      };

      cursor = {
        inactive_timeout = 15;
        no_warps = true;
        warp_on_change_workspace = true;
        min_refresh_rate = 60;
      };

      monitor = [
        "eDP-1,1920x1080@60,0x0,1"
      ];

      misc = {
        focus_on_activate = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        vrr = true;
        vfr = true;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        force_default_wallpaper = 1;
      };

      binds = {
        allow_workspace_cycles = true;
      };

      input = {
        repeat_rate = 25;
        repeat_delay = 269;
        accel_profile = "flat";
        force_no_accel = true;
        sensitivity = 1.0;
        numlock_by_default = true;

        touchpad = {
          scroll_factor = 0.8;
          disable_while_typing = 1;
          natural_scroll = 1;
          clickfinger_behavior = 1;
          middle_button_emulation = 1;
          tap-to-click = 1;
        };
      };

      decoration = {
        rounding = 8;
        shadow = {
          enabled = true;
          render_power = 2;
          range = 8;
        };
        dim_inactive = false;
        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          noise = 1.2e-2;
          contrast = 0.89;
          brightness = 0.85;
          xray = true;
        };
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        new_on_top = true;
      };

    };
  };
}
