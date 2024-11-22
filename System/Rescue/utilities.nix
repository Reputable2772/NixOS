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

    gparted

    # Utilities
    coreutils
    util-linux

    firefox
    nano
    vscodium
    foot
    ungoogled-chromium
  ];
}
