{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.kdeconnect-kde
  ];

  system-config.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  programs.autostart.files = [
    "${pkgs.kdePackages.kdeconnect-kde}/share/applications/org.kde.kdeconnect.daemon.desktop"
    "${pkgs.kdePackages.kdeconnect-kde}/share/applications/org.kde.kdeconnect.nonplasma.desktop"
  ];

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/tel" = "org.kde.kdeconnect.handler.desktop";
    "x-scheme-handler/sms" = "org.kde.kdeconnect.handler.desktop";
  };
}
