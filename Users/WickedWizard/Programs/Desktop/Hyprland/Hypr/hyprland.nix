{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}:
{
  stylix.targets.hyprland.enable = config.wayland.windowManager.hyprland.enable;

  wayland.windowManager.hyprland = {
    inherit (osConfig.programs.hyprland) enable;
    configType = "lua";

    # Use packages from system itself.
    package = null;
    portalPackage = null;

    systemd = {
      enable = !osConfig.programs.hyprland.withUWSM;
      enableXdgAutostart = true;
    };
    xwayland.enable = true;
    settings = {
      config = {
        debug.error_position = 1;

        general = {
          layout = "dwindle";
          resize_on_border = true;
        };

        cursor = {
          inactive_timeout = 15;
          no_warps = true;
          warp_on_change_workspace = true;
          min_refresh_rate = 60;
        };

        misc = {
          focus_on_activate = true;
          disable_splash_rendering = true;
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
          vrr = true;
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
            disable_while_typing = true;
            natural_scroll = true;
            clickfinger_behavior = true;
            middle_button_emulation = true;
            tap_to_click = true;
          };
        };

        decoration = {
          rounding = 8;
          shadow = {
            enabled = false;
            render_power = 2;
            range = 8;
          };
          dim_inactive = false;
          blur = {
            enabled = false;
            size = 8;
            passes = 3;
            noise = 1.2e-2;
            contrast = 0.89;
            brightness = 0.85;
            xray = true;
          };
        };

        dwindle = {
          preserve_split = true;
        };

        master = {
          new_on_top = true;
        };
      };

      monitor = [
        {
          output = "eDP-1";
          mode = "1920x1080@60";
          position = "0x0";
          scale = 1;
        }
        {
          output = "HDMI-A-1";
          mode = "1024x768@60";
          position = "1920x0";
          scale = 1;
          transform = 0;
        }
      ];

      on = [
        {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline ''
              function()
                hl.exec_cmd("${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1")
                hl.exec_cmd("${pkgs.systemd}/bin/systemctl --user daemon-reload")
              end
            '')
          ];
        }
      ];
    };
  };
}
