# Inspiration https://github.com/Srinath10X/catppuccin-waybar/
{ config, ... }:
let
  waybar = {
    exclusive = true;
    gtk-layer-shell = true;
    height = 40;
    layer = "top";
    mod = "dock";
    passthrough = false;
    position = "top";
    modules-left = [ "hyprland/workspaces" "privacy" "custom/pomodoro" ];
    modules-center = [ "mpris" "clock" "gamemode" ];
    modules-right = [ "tray" "wireplumber" "network" "bluetooth" "temperature" "backlight" "battery" ];
    "hyprland/workspaces" = {
      all-outputs = true;
      format = "{icon}";
      format-icons = { active = "  "; default = "  "; persistent = "  "; };
      on-click = "activate";
      on-scroll-down = "hyprctl dispatch workspace e+1";
      on-scroll-up = "hyprctl dispatch workspace e-1";
      persistent-workspaces = { "1" = ""; "2" = ""; "3" = ""; };
    };
    privacy = {
      icon-size = 18;
      icon-spacing = 4;
      modules = [
        {
          tooltip = true;
          tooltip-icon-size = 24;
          type = "screenshare";
        }
        {
          tooltip = true;
          tooltip-icon-size = 24;
          type = "audio-out";
        }
        {
          tooltip = true;
          tooltip-icon-size = 24;
          type = "audio-in";
        }
      ];
      transition-duration = 250;
    };
    "custom/pomodoro" = {
      exec = "uairctl fetch '{name} - {time}'";
      tooltip = false;
      format = " {}";
      on-click = "uairctl toggle";
      on-click-middle = "uairctl prev";
      on-click-right = "uairctl next";
      interval = 1;
    };
    mpris = {
      format = "{player_icon} {title}";
      format-paused = "{status_icon} <i>{title}</i>";
      max-length = 25;
      player-icons = { default = "󰐊"; mpv = "🎵"; };
      status-icons = { paused = "󰏤"; };
    };
    clock = {
      actions = {
        on-click-backward = "tz_down";
        on-click-forward = "tz_up";
        on-click-right = "mode";
        on-scroll-down = "shift_down";
        on-scroll-up = "shift_up";
      };
      calendar = {
        format = {
          days = "<span color='#ecc6d9'><b>{}</b></span>";
          months = "<span color='#ffead3'><b>{}</b></span>";
          today = "<span color='#ff6699'><b><u>{}</u></b></span>";
          weekdays = "<span color='#ffcc66'><b>{}</b></span>";
          weeks = "<span color='#99ffdd'><b>W{}</b></span>";
        };
        mode = "year";
        mode-mon-col = 3;
        on-click-right = "mode";
        on-scroll = 1;
        weeks-pos = "right";
      };
      format = "{:%H:%M} ";
      format-alt = "{:%A - %B %d %Y (%R)} ";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
    };
    gamemode = {
      format = "{glyph}";
      format-alt = "{glyph} {count}";
      glyph = "";
      hide-not-running = true;
      icon-name = "input-gaming-symbolic";
      icon-size = 20;
      icon-spacing = 4;
      tooltip = true;
      tooltip-format = "Games running: {count}";
      use-icon = true;
    };
    tray = {
      icon-size = 20;
      spacing = 10;
    };
    wireplumber = {
      format = "{icon} {volume}%";
      format-icons = {
        car = "";
        default = [ "" "" "" ];
        hands-free = "";
        headphone = "";
        headset = "";
        phone = "";
        portable = "";
      };
      format-muted = " Muted";
      on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      on-scroll-down = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-";
      on-scroll-up = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
      scroll-step = 5;
      tooltip = false;
    };
    "wireplumber#microphone" = {
      format = "{format_source}";
      format-source = " {volume}%";
      format-source-muted = " Muted";
      on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      on-scroll-down = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ 5%-";
      on-scroll-up = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ 5%+";
      scroll-step = 5;
    };
    network = {
      format-alt = "{ifname}:{essid} {ipaddr}/{cidr}";
      format-disconnected = "Disconnected ⚠";
      format-ethernet = "";
      format-linked = "{ifname} (No IP)";
      format-wifi = "  {signalStrength}%";
      tooltip-format = "{essid} - {ifname} via {gwaddr}";
    };
    bluetooth = {
      format = " {status}";
      format-connected = " {num_connections}";
      format-disabled = "";
      tooltip-format = "{device_alias}";
      tooltip-format-connected = " {device_enumerate}";
      tooltip-format-connected-battery = " {device_battery_percentage}";
      tooltip-format-enumerate-connected = "{device_alias}";
    };
    temperature = {
      critical-threshold = 85;
      format = "{temperatureC}°C ";
      format-critical = "{temperatureC}°C ";
      hwmon-path = "/sys/class/hwmon/hwmon4/temp1_input";
    };
    backlight = {
      format = "{percent}% {icon}";
      format-icons = [ "" "" ];
    };
    battery = {
      format = "{icon} {capacity}%";
      format-alt = "{time} {icon}";
      format-charging = " {capacity}%";
      format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
      format-plugged = " {capacity}%";
      states = {
        critical = 20;
        good = 95;
        warning = 30;
      };
    };

    # Currently disabled/unused
    cpu = {
      format = "{icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}";
      format-icons = [
        "<span color='#69ff94'>▁</span>"
        "<span color='#2aa9ff'>▂</span>"
        "<span color='#f8f8f2'>▃</span>"
        "<span color='#f8f8f2'>▄</span>"
        "<span color='#ffffa5'>▅</span>"
        "<span color='#ffffa5'>▆</span>"
        "<span color='#ff9977'>▇</span>"
        "<span color='#dd532e'>█</span>"
      ];
      interval = 1;
    };
    "hyprland/window" = {
      format = "{}";
    };
  };

  waybar_css = ''
    * {
      border: none;
      border-radius: 0;
      font-family: "JetBrainsMono Nerd Font";
      font-weight: bold;
      font-size: 16px;
      min-height: 0;
    }

    window#waybar {
      background: rgba(21, 18, 27, 0);
      background: #1e1e2e;
      color: #cdd6f4;
    }

    tooltip {
      background: #1e1e2e;
      border-radius: 10px;
      border-width: 2px;
      border-style: solid;
      border-color: #11111b;
    }

    #workspaces button {
      padding: 5px;
      color: #b4befe;
    }

    #workspaces button.active {
      color: #a6adc8;
      color: #94e2d5;
    }

    #workspaces button.focused {
      color: #a6adc8;
      background: #eba0ac;
    }

    #workspaces button.urgent {
      color: #11111b;
      background: #a6e3a1;
      border-radius: 10px;
    }

    #workspaces button:hover {
      background: #313244;
      color: #cdd6f4;
    }

    #window,
    #clock,
    #battery,
    #privacy,
    #privacy-item
    #network,
    #bluetooth,
    #temperature,
    #workspaces,
    #tray,
    #mpris,
    #custom-pomodoro,
    #wireplumber,
    #backlight,
    #gamemode,
    #wireplumber.microphone {
      background: #1e1e2e;
      background: #313244;
      opacity: 0.8;
      padding: 0px 10px;
      margin: 3px 0px;
      margin-top: 5px;
      margin-bottom: 5px;
      border-radius: 10px 10px 10px 10px;
      border: 1px solid #181825;
    }

    #temperature.critical {
      color: #eba0ac;
    }

    /* #privacy-item.screenshare,
        #privacy-item.audio-in,
        #privacy-item.audio-out {
        border-radius: 0px;
        border-left: none;
        border-right: none;
        } */

    /* #tray {
        border-radius: 10px;
        margin-right: 15px;
        } */

    #workspaces {
      background: #1e1e2e;
      background: #313244;
      border-radius: 15px;
      margin-left: 10px;
      padding-right: 0px;
      padding-left: 5px;
    }

    #window {
      border-radius: 15px;
      margin-left: 40px;
      margin-right: 40px;
    }

    #clock {
      color: #fab387;
      border-radius: 15px;
      margin-right: 10px;
      padding: 0 15px;
      border-right: 0px;
    }

    #network {
      color: #f9e2af;
      border-radius: 0px 15px 15px 0px;
      border-left: 0px;
      border-right: 0px;
      padding-right: 17px;
      margin-right: 10px;
    }

    #bluetooth,
    #gamemode,
    #backlight {
      color: #89b4fa;
    }

    #wireplumber {
      color: #89b4fa;
      /* border-left: 0px; */
      /* border-right: 0px; */
      /* padding-left: 17px; */
      border-radius: 15px 15px 15px 15px;
    }

    #wireplumber.microphone {
      color: #cba6f7;
      /* border-left: 0px; */
      /* border-right: 0px; */
      border-radius: 15px 15px 15px 15px;
      /* margin-right: 10px; */
    }

    #battery {
      color: #a6e3a1;
      /* border-radius: 10px; */
      margin-right: 10px;
      padding: 0 15px;
      /* border-right: 0px; */
      /* border-left: 0px; */
    }
  '';
in
{

  programs.waybar = {
    enable = config.wayland.windowManager.hyprland.enable;
    settings = {
      mainBar = waybar;
    };
    style = waybar_css;

    # Fixes https://github.com/nix-community/home-manager/issues/3599
    systemd.enable = false;
  };

  # programs.autostart.autostartPackages = lib.optionals config.programs.waybar.enable [
  #   (pkgs.makeDesktopItem {
  #     name = "Waybar";
  #     exec = "waybar";
  #     desktopName = "Waybar";
  #     categories = [ "Applications" ];
  #   })
  # ];

  # xdg.configFile = {
  #   waybar = {
  #     enable = hyprland.enable;
  #     target = "waybar/config";
  #     text = builtins.toJSON waybar;
  #   };
  #   style = {
  #     enable = hyprland.enable;
  #     target = "waybar/style.css";
  #     text = waybar_css;
  #   };
  # };
}
