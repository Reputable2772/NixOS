{ config, pkgs, lib, ... }:
let
  inherit (lib) mkForce;
  inherit (lib.strings) concatStringsSep toLower;

  variant = "Mocha";
  accent = "Blue";
  size = "Standard";
  # dark = "Dark";

  qt_theme = pkgs.catppuccin-kvantum.override {
    inherit variant accent;
  };
in
{
  home.packages = with pkgs; [
    # Needed only if GTK4 apps are themed with GTK3
    # adw-gtk3
  ] ++ [ qt_theme ];

  # Both DConf and GTK need to be set, since the dconf2nix generated file may override it otherwise.
  gtk = {
    enable = true;
    theme =
      let
        tweaks = [ "rimless" "normal" "float" ];
      in
      {
        name = "catppuccin-${toLower variant}-${toLower accent}-${toLower size}+${concatStringsSep "," tweaks}";
        package = pkgs.catppuccin-gtk.override {
          accents = [ (toLower accent) ];
          inherit tweaks;
          size = toLower size;
          variant = toLower variant;
        };
      };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 0;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 0;
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
