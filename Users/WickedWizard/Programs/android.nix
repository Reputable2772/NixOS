{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    # ADB and related stuff
    android-tools
    android-udev-rules

    # Waydroid related stuff
    nur.repos.ataraxiasjel.waydroid-script
  ];
}
