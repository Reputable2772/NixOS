{
  osConfig,
  pkgs,
  lib,
  ...
}:
let
  # Also known as flavor
  variant = "mocha";
  accent = "blue";

  # Only for Catppuccin GTK
  tweaks = [ ];
  size = "standard";

  inherit (lib.strings) concatStringsSep optionalString;

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
    # This needs to be set using Application Styles in KDE System Settings, to avoid segfaults with Plasma Shell.
    style.name = lib.mkIf (!osConfig.services.desktopManager.plasma6.enable) "kvantum";
  };

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    font-antialiasing = "grayscale";
    font-hinting = "slight";
  };

  gtk.theme = {
    name =
      "catppuccin-${variant}-${accent}-${size}"
      + optionalString (tweaks != [ ]) ("+" + concatStringsSep "," tweaks);
    package = gtk_theme;
  };

  xdg.configFile = lib.mkIf (!osConfig.services.desktopManager.plasma6.enable) {
    # Set theme name
    "Kvantum/kvantum.kvconfig".text = ''
      theme=catppuccin-${variant}-${accent}
    '';
    # Symlink theme directory
    "Kvantum/catppuccin-${variant}-${accent}".source =
      "${qt_theme}/share/Kvantum/catppuccin-${variant}-${accent}";
  };
}
