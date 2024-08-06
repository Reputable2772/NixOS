{ config, pkgs, lib, ... }: {
  gtk.iconTheme = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
  };
  dconf.settings."org/gnome/desktop/interface" = {
    icon-theme = lib.mkForce config.gtk.iconTheme.name;
  };

  # Icon theme is only for qt apps, and to be configured manually using
  # qt5ct & qt6ct.
  home.packages = with pkgs; [ papirus-icon-theme ];
}
