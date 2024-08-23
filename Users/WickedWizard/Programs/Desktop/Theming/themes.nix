{ pkgs, lib, config, ... }:
let
  # Also known as flavor
  variant = "Mocha";
  accent = "Blue";

  # Only for Catppuccin GTK
  tweaks = [ ];
  size = "standard";

  inherit (lib.strings) concatStringsSep optionalString toLower;
  inherit (lib.modules) mkForce;

  qt_theme = pkgs.catppuccin-kvantum.override {
    inherit variant accent;
  };
  gtk_theme = pkgs.catppuccin-gtk.override {
    inherit size tweaks;
    accents = [ (toLower accent) ];
    variant = toLower variant;
  };
in
{
  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };

  gtk.theme = {
    name = "catppuccin-${toLower variant}-${toLower accent}-${size}" + optionalString (tweaks != [ ]) ("+" + concatStringsSep "," tweaks);
    package = gtk_theme;
  };

  xdg.configFile = {
    # Set theme name
    "Kvantum/kvantum.kvconfig".text = ''
      theme=Catppuccin-${variant}-${accent}
    '';
    # Symlink theme directory
    "Kvantum/Catppuccin-${variant}-${accent}".source = "${qt_theme}/share/Kvantum/Catppuccin-${variant}-${accent}";
  };

  dconf.settings."org/gnome/desktop/interface" = {
    gtk-theme = mkForce config.gtk.theme.name;
  };
}
