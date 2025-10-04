{ config, lib, ... }:
{
  services.power-profiles-daemon.enable = lib.mkForce (!config.programs.hyprland.enable);
  services.auto-cpufreq = {
    enable = config.programs.hyprland.enable;
    settings = {
      charger = {
        governor = "performance";
        turbo = "auto";
      };

      battery = {
        governor = "powersave";
        scaling_max_freq = 1460000;
        turbo = "never";
        enable_thresholds = true;
        start_threshold = 20;
        stop_threshold = 90;
      };
    };
  };
}
