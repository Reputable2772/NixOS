{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    bottom
    calibre
    dnsutils
    eza
    gocryptfs
    libsForQt5.kdenlive
    ungoogled-chromium
    neofetch
    rmtrash
    rclone
    appimage-run
    gnome-podcasts
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
