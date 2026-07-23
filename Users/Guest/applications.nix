{ pkgs, ... }:
{
  home.packages = with pkgs; [
    foot
    tmux
  ];

  services.flatpak.packages = [
    "org.videolan.VLC"
    "io.mpv.Mpv"
    "com.google.Chrome"
    "org.mozilla.firefox"
    "org.gnome.Papers"
    "org.libreoffice.LibreOffice"
  ];
}
