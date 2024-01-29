{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    appimage-run
    conky
    gocryptfs

    xwaylandvideobridge
    authenticator
  ];
}
