{ pkgs, ... }: {
  home.packages = with pkgs; [ stremio mpv youtube-dl yt-dlp ];
}
