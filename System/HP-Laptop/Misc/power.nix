{ lib, ... }: {
  powerManagement.powertop.enable = true;

  services.power-profiles-daemon.enable = lib.mkForce false;
  services.auto-cpufreq = {
    enable = true;
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
