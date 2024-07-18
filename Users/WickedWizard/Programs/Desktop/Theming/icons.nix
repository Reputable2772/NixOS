{ config, pkgs, lib, ... }: {
  gtk.iconTheme = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
  };
  dconf.settings."org/gnome/desktop/interface" = {
    icon-theme = lib.mkForce config.gtk.iconTheme.name;
  };
}
