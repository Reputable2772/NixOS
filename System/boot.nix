{ config, pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
    "net.ipv4.ip_unprivileged_port_start" = 443;
    "net.core.rmem_max" = 2500000;
    "net.core.wmem_max" = 2500000;
  };
  boot.extraModulePackages = [
    config.boot.kernelPackages.rtl8821ce
  ];
}
