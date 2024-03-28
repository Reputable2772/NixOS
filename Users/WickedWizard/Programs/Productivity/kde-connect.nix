{ pkgs, ... }: {
  home.packages = with pkgs; [
    kdePackages.kdeconnect-kde

    # Icons and themes
    kdePackages.breeze-icons
    kdePackages.breeze-gtk
    kdePackages.breeze
  ];

  xdg.configFile = {
    "autostart/kdeconnectd.desktop".source = "${pkgs.kdePackages.kdeconnect-kde}/share/applications/org.kde.kdeconnect.daemon.desktop";
    "autostart/kdeconnect-indicator.desktop" = {
      enable = true;
      source = "${pkgs.kdePackages.kdeconnect-kde}/share/applications/org.kde.kdeconnect.nonplasma.desktop";
      executable = false;
    };
  };
}
