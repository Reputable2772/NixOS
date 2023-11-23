{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    appimage-run
    conky
    gocryptfs

    giara

    xwaylandvideobridge

    deluge-gtk
    livecaptions
  ];
}
