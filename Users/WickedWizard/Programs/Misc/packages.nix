{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    appimage-run
    conky
    gocryptfs
    rclone

    nur.repos.mikilio.xwaylandvideobridge

    deluge-gtk
    livecaptions

    # fragments
    # textpieces
  ];
}
