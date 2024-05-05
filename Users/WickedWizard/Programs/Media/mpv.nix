{ pkgs, ... }: {
  programs.mpv = {
    enable = true;
    config = {
      ytdl-format = "bestvideo[height<=1080][vcodec!=vp9]+bestaudio/best";
    };
    scripts = with pkgs.mpvScripts; [
      mpris
      quality-menu
      sponsorblock
    ];
  };
}
