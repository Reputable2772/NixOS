{ config, pkgs, lib, ... }:
let
  theme = "Catppuccin-Mocha-Standard-Blue-Dark";
  iconTheme = "Adwaita";
  inherit (lib) mkForce;
in
{
  home.packages = with pkgs; [
    adw-gtk3
    gradience
  ];

  gtk = {
    enable = true;
    theme = {
      name = theme;
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        tweaks = [ "rimless" "normal" "float" ];
        size = "standard";
        variant = "mocha";
      };
    };
    iconTheme = {
      name = iconTheme;
      package = pkgs.gnome.adwaita-icon-theme;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = mkForce "prefer-dark";
      cursor-theme = mkForce "Nordic-cursors";
      gtk-theme = mkForce theme;
      icon-theme = mkForce iconTheme;
    };
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };
}
