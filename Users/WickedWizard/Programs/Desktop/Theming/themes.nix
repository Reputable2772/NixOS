{ pkgs, lib, config, ... }:
let
  # Also known as flavor
  variant = "mocha";
  accent = "blue";

  # Only for Catppuccin GTK
  tweaks = [ ];
  size = "standard";

  inherit (lib.strings) concatStringsSep optionalString;
  inherit (lib.modules) mkForce;

  qt_theme = pkgs.catppuccin-kvantum.override {
    inherit variant accent;
  };
  gtk_theme = pkgs.catppuccin-gtk.override {
    inherit size tweaks;
    accents = [ accent ];
    variant = variant;
  };
in
{
  qt = {
    enable = true;
    style.name = "kvantum";
  };

  gtk.theme = {
    name = "catppuccin-${variant}-${accent}-${size}" + optionalString (tweaks != [ ]) ("+" + concatStringsSep "," tweaks);
    package = gtk_theme;
  };

  xdg.configFile = {
    # Set theme name
    "Kvantum/kvantum.kvconfig".text = ''
      theme=catppuccin-${variant}-${accent}
    '';
    # Symlink theme directory
    "Kvantum/catppuccin-${variant}-${accent}".source = "${qt_theme}/share/Kvantum/catppuccin-${variant}-${accent}";
  };

  dconf.settings."org/gnome/desktop/interface" = {
    gtk-theme = mkForce config.gtk.theme.name;
  };
}
