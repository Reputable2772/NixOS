# Inspiration https://github.com/alberkev03/dotfiles/
{ config, lib, ... }:
let
  waybar = {
    layer = "top";
    height = 30;
    modules-left = [ "custom/logout" "hyprland/workspaces" ];
    modules-center = [ "clock" "mpris" "gamemode" ];
    modules-right = [ "tray" "temperature" "wireplumber" "bluetooth" "battery" "cpu" "memory" "backlight" "network" ];
    position = "top";
    spacing = 4;

    "hyprland/workspaces" = {
      all-outputs = true;
      format = "{icon}";
      format-icons = {
        active = "<span color='#cad3f5'></span>";
        default = "<span color='#cad3f5'></span>";
      };
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
      format = "<span color='#c40000'> </span>{}";
      on-click = "uairctl toggle";
      on-click-middle = "uairctl prev";
      on-click-right = "uairctl next";
      interval = 10;
    };

    clock = {
      format = "<span color='#8bd5ca'> </span>{:%H:%M}";
      tooltip = true;
      tooltip-format = "<span color='#8bd5ca'>󰃭 </span>{:%d-%m-%Y}";
    };
    mpris = {
      format = "{player_icon} {title}";
      format-paused = "{status_icon} <i>{title}</i>";
      max-length = 25;
      player-icons = { default = "󰐊"; mpv = "🎵"; };
      status-icons = {
        paused = "";
        playing = "";
      };
    };
    gamemode = {
      format = "{glyph}";
      format-alt = "{glyph} {count}";
      glyph = "<span color='#81ef93'>󰊴 </span>";
      hide-not-running = true;
      icon-name = "input-gaming-symbolic";
      icon-size = 20;
      icon-spacing = 4;
      tooltip = true;
      tooltip-format = "Games running: {count}";
      use-icon = true;
    };

    tray.spacing = 10;
    temperature = {
      critical-threshold = 85;
      format = " {temperatureC}°C ";
      format-critical = "<span color='#e0140d'> </span> {temperatureC}°C";
      hwmon-path = "/sys/class/hwmon/hwmon4/temp1_input";
    };
    wireplumber = {
      format = "{icon} {volume}%";
      format-icons = {
        car = "";
        default = [ "" "" "" ];
        hands-free = "";
        headphone = "";
        headset = "";
        phone = "";
        portable = "";
      };
      format-muted = "󰝟 {volume}%";
      on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      on-scroll-down = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-";
      on-scroll-up = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
      scroll-step = 5;
      tooltip = false;
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
    battery = {
      format = "{icon}  {capacity}%";
      format-alt = "{time}";
      format-charging = "<span color='#2bce0e'>󰂉 </span> {capacity}%";
      format-icons = [ "<span color='#bc1b0d'> </span>" "<span color='#cbce0e'> </span>" "<span color='#2bce0e'> </span>" ];
      format-plugged = "󰂅 {capacity}%";
      states = {
        critical = 20;
        warning = 40;
        good = 95;
      };
    };
    cpu = {
      format = "<span color='#f5a97f'> </span> {usage}%";
      tooltip = false;
    };
    memory = {
      format = "<span color='#eed49f'> </span> {}%";
      tooltip-format = "{used:0.1f}GiB used";
    };
    backlight = {
      format = "{icon} {percent}%";
      format-icons = [ "󰃞" "󰃝" "󰃟" "󰃠" ];
    };
    network = {
      format-alt = "{ifname}: {ipaddr}/{cidr}";
      format-disconnected = "<span color='#ed8796'>󰢿 </span>";
      format-ethernet = "<span color='#a6da95'>󰢾 </span>";
      format-linked = "  {ifname} (No IP)";
      format-wifi = "  {essid} ({signalStrength}%)";
      tooltip-format = "  {ifname} via {gwaddr}";
    };
  };
  waybar_css = ''
    * {
      border: none;
      /* `otf-font-awesome` is required to be installed for icons */
      font-family: 'Fira Code', Roboto, Helvetica, Arial, sans-serif;
      font-size: 13px;
      font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
      min-height: 20px;
    }

    window#waybar {
      background-color: transparent;
    }

    #workspaces button {
      background-color: #24273a;
      color: #eceff4;
    }

    ${lib.concatMapStringsSep ", " (x: "#" + lib.replaceStrings [ "hyprland/" "/" ] [ "" "-" ] x) waybar.modules-left} {
      border-radius: 10px;
      background-color: #24273a;
      font-size: 20px;
      margin-left: 6px;
      color: #eceff4;
      margin-top: 6px;
    }

    ${lib.concatMapStringsSep ", " (x: "#" + lib.replaceStrings [ "/" ] [ "-" ] x) (waybar.modules-right ++ waybar.modules-center)} {
      border-radius: 10px;
      background-color: #24273a;
      color: #cad3f5;
      margin-top: 6px;
      padding-left: 10px;
      padding-right: 10px;
      margin-right: 6px;
    }
  '';
in
{

  programs.waybar = {
    inherit (config.wayland.windowManager.hyprland) enable;
    settings = {
      mainBar = waybar;
    };
    style = waybar_css;

    # Fixes https://github.com/nix-community/home-manager/issues/3599
    systemd.enable = false;
  };
}
