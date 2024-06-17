{ config, pkgs, lib, ... }: {
  services.hypridle = {
    inherit (config.wayland.windowManager.hyprland) enable;
    settings = {
      general = {
        lock_cmd = "${pkgs.procps}/bin/pidof hyprlock || ${lib.getExe pkgs.hyprlock}";
        before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
        after_sleep_cmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 210;
          on-timeout = "${lib.getExe pkgs.brightnessctl} -s set 10";
          on-resume = "${lib.getExe pkgs.brightnessctl} -r";
        }
        {
          timeout = 240;
          on-timeout = "${pkgs.systemd}/bin/loginctl lock-session";
        }
        {
          timeout = 270;
          on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
          on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        }
        {
          timeout = 300;
          on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };
  };
}
