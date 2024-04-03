{ pkgs, ... }: {
  home.packages = with pkgs; [
    gocryptfs

    xwaylandvideobridge
    authenticator
  ];
}
