{ config, pkgs, ... }: {
  programs.firefox = {
    enable = true;
    profiles."default" = {
      isDefault = true;
      name = "default";
      path = "../../Documents/Browsers/Firefox/";
    };
  };

  # xdg.configFile."autostart/firefox.desktop".source = "${pkgs.firefox}/share/applications/firefox.desktop";
}
