{ pkgs, ... }:
{
  home.packages = with pkgs; [
    foot
  ];

  services.flatpak.packages = [
    "org.videolan.VLC"
    "io.mpv.Mpv"
    "com.google.Chrome"
    "org.mozilla.firefox"
  ];
}
