{ pkgs, ... }: {
  home.packages = with pkgs; [
    kdePackages.kdeconnect-kde
  ];

  programs.autostart.files = [
    "${pkgs.kdePackages.kdeconnect-kde}/share/applications/org.kde.kdeconnect.daemon.desktop"
    "${pkgs.kdePackages.kdeconnect-kde}/share/applications/org.kde.kdeconnect.nonplasma.desktop"
  ];
}
