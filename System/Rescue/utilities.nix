{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Memory testers
    memtester
    memtest86plus
    memtest_vulkan

    # Data recovery
    testdisk
    ddrescue
    smartmontools
    cryptsetup

    gparted

    # Hardware/boot triage
    efibootmgr
    pciutils
    usbutils

    # Utilities
    coreutils
    util-linux
    rsync
    tmux

    firefox
    nano
    vscodium
    foot
    ungoogled-chromium
  ];
}
