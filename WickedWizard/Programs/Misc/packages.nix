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

    nur.repos.mikilio.xwaylandvideobridge

    fragments
    metadata-cleaner
    gnome-obfuscate
    newsflash
    # textpieces
  ];
}
