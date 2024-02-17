{ config, pkgs, ... }: {
  programs.librewolf = {
    enable = true;
    settings = {
      "privacy.resistFingerprinting.letterboxing" = true;
      "network.http.referer.XOriginPolicy" = 2;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
    };
  };

  xdg.configFile."autostart/librewolf.desktop".source = "${pkgs.librewolf}/share/applications/librewolf.desktop";
}
