{ pkgs, ... }: {
  home.packages = with pkgs; [
    feishin
    mpv
  ];
}
