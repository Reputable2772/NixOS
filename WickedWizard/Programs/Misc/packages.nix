{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    calibre
    gocryptfs
    libsForQt5.kdenlive
    rclone
    appimage-run
    gnome-podcasts
    podman-compose
    bottles
    flatpak
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
