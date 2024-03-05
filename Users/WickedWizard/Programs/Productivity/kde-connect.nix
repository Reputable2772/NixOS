{ pkgs, ... }: {
  home.packages = with pkgs; [ kdePackages.kdeconnect-kde ];

  xdg.configFile."autostart/kdeconnectd.desktop".source = "${pkgs.kdePackages.kdeconnect-kde}/share/applications/org.kde.kdeconnect.daemon.desktop";
}
