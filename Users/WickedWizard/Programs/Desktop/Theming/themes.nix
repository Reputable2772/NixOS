{ config, pkgs, lib, ... }:
let
  inherit (lib) mkForce;
  inherit (lib.strings) toLower;

  variant = "Mocha";
  accent = "Blue";
  size = "Standard";
  dark = "Dark";

  qt_theme = pkgs.catppuccin-kvantum.override {
    inherit variant accent;
  };
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
      name = "Catppuccin-${variant}-${size}-${accent}-${dark}";
      package = pkgs.catppuccin-gtk.override {
        accents = [ (toLower accent) ];
        tweaks = [ "rimless" "normal" "float" ];
        size = toLower size;
        variant = toLower variant;
      };
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = mkForce "prefer-dark";
      gtk-theme = mkForce config.gtk.theme.name;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
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
  };
}
