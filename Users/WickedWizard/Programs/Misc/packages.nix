{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    appimage-run
    conky
    gocryptfs

    nur.repos.mikilio.xwaylandvideobridge

    deluge-gtk
    livecaptions
  ];
}
