{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "quiet"
      "loglevel=3"
    ];
    plymouth.enable = true;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.rebootForBitlocker = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
    kernel.sysctl = {
      "kernel.sysrq" = 1;

      # Required for caddy.
      "net.ipv4.ip_unprivileged_port_start" = 80;
      "net.core.rmem_max" = 7500000;
      "net.core.wmem_max" = 7500000;
    };
    initrd.systemd.enable = true;

    # RTL8821CE
    # Overlay doesn't apply if `config.boot.kernelPackages.rtl8821ce` is used.
    # extraModulePackages = with pkgs; [ linuxKernel.packages.linux_zen.rtl8821ce ];
    # blacklistedKernelModules = [ "rtw88_8821ce" ];
  };
}
