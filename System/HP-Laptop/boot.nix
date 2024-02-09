{ config, pkgs, ... }: {
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
    "net.ipv4.ip_unprivileged_port_start" = 80;
    "net.core.rmem_max" = 2500000;
    "net.core.wmem_max" = 2500000;
  };
  boot.extraModulePackages = with pkgs.linuxKernel.packages; [ linux_zen.rtl8821ce ];
  boot.blacklistedKernelModules = [ "rtw88_8821ce" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
}
