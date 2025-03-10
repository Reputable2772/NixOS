{ config, ... }:
{
  services.udev.extraRules = ''
    # Hibernate's device on Low Power. Set 20 to be your low power value, in percent.
    SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="30", RUN+="${config.systemd.package}/bin/systemctl hibernate"
  '';
}
