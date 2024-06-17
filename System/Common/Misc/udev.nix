{ config, ... }:
{
  services.udev.extraRules = ''
    # Suspend's device on Low Power. Set 20 to be your low power value, in percent.
    SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="${toString 20}", RUN+="${config.systemd.package}/bin/systemctl suspend"
  '';
}
