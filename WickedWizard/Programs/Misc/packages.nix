{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    bottom
    calibre
    dnsutils
    eza
    gocryptfs
    neofetch
    rmtrash
    rclone
    podman-compose

    protonvpn-cli
    fluffychat
    libreoffice-qt
    android-tools

    nur.repos.mikilio.xwaylandvideobridge

    fragments
    metadata-cleaner
    gnome-obfuscate
    # textpieces
  ];
}
