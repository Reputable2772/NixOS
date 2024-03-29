{ config, pkgs, lib, ... }:
let
  inherit (lib) mkForce strings;
  variant = "Mocha";
  accent = "Blue";
  size = "Standard";
  dark = "Dark";
  qt_theme = (pkgs.catppuccin-kvantum.override {
    inherit variant accent;
  });
  gtk_theme = "Catppuccin-${variant}-${size}-${accent}-${dark}";
in
{
  home.packages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum

    # Needed only if GTK4 apps are themed with GTk3
    # adw-gtk3
  ] ++ [ qt_theme ];

  # Both DConf and GTK need to be set, since the dconf2nix generated file may override it otherwise.
  gtk = {
    enable = true;
    theme = {
      name = gtk_theme;
      package = pkgs.catppuccin-gtk.override {
        accents = [ (strings.toLower accent) ];
        tweaks = [ "rimless" "normal" "float" ];
        size = strings.toLower size;
        variant = strings.toLower "mocha";
      };
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = mkForce "prefer-dark";
      gtk-theme = mkForce gtk_theme;
    };
  };

  qt = {
    enable = true;
    platformTheme = "qtct";
    style.name = "kvantum";
  };

  xdg.configFile = {
    kvantum = {
      enable = true;
      target = "Kvantum/kvantum.kvconfig";
      text = ''
        theme=Catppuccin-${variant}-${accent}
      '';
    };
    qt_theme = {
      enable = true;
      target = "Kvantum/Catppuccin-${variant}-${accent}";
      recursive = true;
      source = "${qt_theme}/share/Kvantum/Catppuccin-${variant}-${accent}";
    };

    gtk_theme = {
      enable = true;
      target = "gtk-4.0";
      source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0";
      recursive = true;
    };
  };
}
