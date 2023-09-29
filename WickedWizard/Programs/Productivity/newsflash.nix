{ config, pkgs, ... }: {
  home.packages = with pkgs; [ newsflash ];

  xdg.configFile."autostart/newsflash.desktop".source = "${pkgs.newsflash}/share/applications/newsflash.desktop";
}
