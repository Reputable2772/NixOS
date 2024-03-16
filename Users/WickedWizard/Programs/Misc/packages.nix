{ pkgs, ... }: {
  home.packages = with pkgs; [
    appimage-run
    gocryptfs

    xwaylandvideobridge
    authenticator
  ];
}
