{
  osConfig,
  pkgs,
  lib,
  ...
}:
{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  qt.platformTheme.name = lib.mkIf (!osConfig.services.desktopManager.plasma6.enable) "qtct";

  # Icon theme is only for qt apps, and to be configured manually using
  # qt5ct & qt6ct.
  home.packages = with pkgs; [ papirus-icon-theme ];
}
