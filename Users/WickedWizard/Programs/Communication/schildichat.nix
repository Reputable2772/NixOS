{ pkgs, ... }: {
  home.packages = with pkgs; [ schildichat-desktop ];

  # xdg.configFile."autostart/schildichat.desktop".source = "${pkgs.schildichat-desktop}/share/applications/schildichat-desktop.desktop";
}
