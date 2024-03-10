{ pkgs, ... }: {
  home.packages = with pkgs; [
    dex
    polkit_gnome
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      exec-once = [
        "${pkgs.playerctl}/bin/playerctld daemon"
        "${pkgs.dex}/bin/dex --autostart"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      ];

      general = {
        layout = "dwindle";
        resize_on_border = true;
        cursor_inactive_timeout = 15;
        no_border_on_floating = true;
      };

      monitor = [
        "eDP-1,1920x1080@60,0x0,1"
      ];

      misc = {
        focus_on_activate = true;
        disable_hyprland_logo = false;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = false;
        vrr = true;
        vfr = true;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        no_direct_scanout = false;
        force_default_wallpaper = 1;
      };

      binds = {
        allow_workspace_cycles = true;
      };

      input = {
        repeat_rate = 25;
        repeat_delay = 269;
        accel_profile = "flat";
        # force_no_accel = true;
        sensitivity = 1.0;

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
        drop_shadow = "yes";
        shadow_range = 8;
        shadow_render_power = 2;
        "col.shadow" = "rgba(00000044)";
        dim_inactive = false;
        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          noise = 0.012;
          contrast = 0.89;
          brightness = 0.85;
          xray = true;
        };
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
        no_gaps_when_only = false;
      };

      master = {
        new_on_top = true;
        no_gaps_when_only = false;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_min_speed_to_force = 5;
      };
    };
  };
}
