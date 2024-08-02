{ pkgs, ... }:
let
  variant = "Mocha";
  accent = "Blue";

  qt_theme = pkgs.catppuccin-kvantum.override {
    inherit variant accent;
  };
in
{
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
