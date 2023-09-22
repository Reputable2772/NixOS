{ config, pkgs, ... }: {
  home.packages = with pkgs; [ obsidian ];

  xdg.configFile."autostart/obsidian.desktop".source = "${pkgs.obsidian}/share/applications/obsidian.desktop";
}
