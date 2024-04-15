{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
    kernel.sysctl = {
      "kernel.sysrq" = 1;
      "net.ipv4.ip_unprivileged_port_start" = 80;
      "net.core.rmem_max" = 2500000;
      "net.core.wmem_max" = 2500000;
    };
    initrd.kernelModules = [ "amdgpu" ];

    # RTL8821CE
    extraModulePackages = with pkgs; [ linuxKernel.packages.linux_zen.rtl8821ce ];
    blacklistedKernelModules = [ "rtw88_8821ce" ];
  };
}
