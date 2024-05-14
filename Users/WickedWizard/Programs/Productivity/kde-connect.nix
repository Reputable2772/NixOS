{ pkgs, ... }: {
  home.packages = with pkgs; [
    kdePackages.kdeconnect-kde

    # Icons and themes
    kdePackages.breeze-icons
    kdePackages.breeze-gtk
    kdePackages.breeze
  ];

  programs.autostart.files = [
    "${pkgs.kdePackages.kdeconnect-kde}/share/applications/org.kde.kdeconnect.daemon.desktop"
    "${pkgs.kdePackages.kdeconnect-kde}/share/applications/org.kde.kdeconnect.nonplasma.desktop"
  ];
}
