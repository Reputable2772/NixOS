{ config, pkgs, ... }: {
  home.packages = with pkgs; [ newsflash rssguard ];

  xdg.configFile."autostart/newsflash.desktop".source = "${pkgs.newsflash}/share/applications/io.gitlab.news_flash.NewsFlash.desktop";
}
