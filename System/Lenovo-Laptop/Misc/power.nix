{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.power-profiles-daemon.enable = lib.mkForce (!config.programs.hyprland.enable);
  powerManagement.powertop.enable = true;
  services.tlp.enable = config.programs.hyprland.enable;
  environment.systemPackages = lib.optional config.services.tlp.enable (
    pkgs.callPackage ../../../Packages/tlpui.nix { }
  );
  services.tlp.settings = {
    TLP_ENABLE = "1";
    TLP_WARN_LEVEL = "3";

    TLP_DEFAULT_MODE = "AC";

    CPU_DRIVER_OPMODE_ON_AC = "active";
    CPU_DRIVER_OPMODE_ON_BAT = "passive";

    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

    CPU_MIN_PERF_ON_AC = "0";
    CPU_MAX_PERF_ON_AC = "100";

    CPU_MIN_PERF_ON_BAT = "0";
    CPU_MAX_PERF_ON_BAT = "1";

    CPU_BOOST_ON_AC = "1";
    CPU_BOOST_ON_BAT = "0";

    CPU_HWP_DYN_BOOST_ON_AC = "1";
    CPU_HWP_DYN_BOOST_ON_BAT = "0";

    PLATFORM_PROFILE_ON_AC = "performance";
    PLATFORM_PROFILE_ON_BAT = "low-power";

    MEM_SLEEP_ON_AC = "deep";
    MEM_SLEEP_ON_BAT = "deep";

    INTEL_GPU_MIN_FREQ_ON_AC = "0";
    INTEL_GPU_MAX_FREQ_ON_AC = "0";
    INTEL_GPU_BOOST_FREQ_ON_AC = "0";

    INTEL_GPU_MIN_FREQ_ON_BAT = "0";
    INTEL_GPU_MAX_FREQ_ON_BAT = "150";
    INTEL_GPU_BOOST_FREQ_ON_BAT = "150";

    WIFI_PWR_ON_AC = "off";
    WIFI_PWR_ON_BAT = "on";

    RUNTIME_PM_ON_AC = "on";
    RUNTIME_PM_ON_BAT = "auto";

    PCIE_ASPM_ON_AC = "performance";
    PCIE_ASPM_ON_BAT = "powersupersave";

    USB_AUTOSUSPEND = "1";
    USB_EXCLUDE_AUDIO = "0";
    USB_EXCLUDE_PRINTER = "0";

    RESTORE_DEVICE_STATE_ON_STARTUP = "1";

    START_CHARGE_THRESH_BAT0 = "75";
    STOP_CHARGE_THRESH_BAT0 = "80";
    RESTORE_THRESHOLDS_ON_BAT = "1";
  };

  # services.auto-cpufreq = {
  #   enable = config.programs.hyprland.enable;
  #   settings = {
  #     charger = {
  #       governor = "performance";
  #       turbo = "auto";
  #     };

  #     battery = {
  #       governor = "powersave";
  #       scaling_max_freq = 1460000;
  #       turbo = "never";
  #       enable_thresholds = true;
  #       start_threshold = 20;
  #       stop_threshold = 90;
  #     };
  #   };
  # };
}
