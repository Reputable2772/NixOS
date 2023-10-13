{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    calibre
    gocryptfs
    libsForQt5.kdenlive
    ungoogled-chromium
    rclone
    appimage-run
    gnome-podcasts
    podman-compose
    bottles

    protonvpn-cli
    libreoffice-qt
    conky
    android-tools

    nur.repos.mikilio.xwaylandvideobridge

    fragments
    livecaptions
    metadata-cleaner
    gnome-obfuscate
    # textpieces
  ];
}
