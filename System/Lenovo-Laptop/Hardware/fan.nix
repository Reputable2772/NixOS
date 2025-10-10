{
  config,
  lib,
  ...
}:
{
  services.thinkfan.enable = true;

  boot.kernelParams = [ "fan_control=1" ];

  environment.etc."thinkfan.conf".text = ''
    # Fan control interface for ThinkPad
    tp_fan /proc/acpi/ibm/fan

    # Temperature sensors (adjust if different on your system)
    hwmon /sys/devices/platform/coretemp.0/hwmon/hwmon4/device/hwmon/hwmon4/temp1_input
    hwmon /sys/devices/platform/coretemp.0/hwmon/hwmon4/device/hwmon/hwmon4/temp2_input
    hwmon /sys/devices/platform/coretemp.0/hwmon/hwmon4/device/hwmon/hwmon4/temp3_input
    hwmon /sys/devices/platform/coretemp.0/hwmon/hwmon4/device/hwmon/hwmon4/temp4_input
    hwmon /sys/devices/platform/coretemp.0/hwmon/hwmon4/device/hwmon/hwmon4/temp5_input


    # Fan levels and temperature ranges (°C)
    (1  0     48)      # Fan level 1 below 48°C
    (2  48    58)      # Fan level 2 for light warmth
    (3  58    65)      # Fan level 3 for typical usage
    (4  65    72)      # Fan level 4 for medium load
    (5  72    78)      # Fan level 5 for gaming or heavy usage
    (6  78    83)      # Fan level 6 for high temps
    (7  83  32767)     # Max fan speed for very high temps
  '';

  systemd.services.thinkfan.environment.THINKFAN_ARGS = lib.mkDefault (
    lib.escapeShellArgs (
      [
        "-c"
        "/etc/thinkfan.conf"
      ]
      ++ config.services.thinkfan.extraArgs
    )
  );
}
