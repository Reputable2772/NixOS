{ config, pkgs, ... }: {
  home.packages = with pkgs; [ rssguard ];

  # xdg.configFile."autostart/rssguard.desktop".source = "${pkgs.rssguard}/share/applications/io.github.martinrotter.rssguard.desktop";
}
