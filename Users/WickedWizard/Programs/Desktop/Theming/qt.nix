{ pkgs, ... }:
let
  variant = "Mocha";
  accent = "Blue";
  theme = (pkgs.catppuccin-kvantum.override {
    inherit variant accent;
  });
in
{
  home.packages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum
    qt5.qtwayland
    qt6.qtwayland
    qt5ct
    kdePackages.qt6ct
  ] ++ [ theme ];

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
    theme = {
      enable = true;
      target = "Kvantum/Catppuccin-${variant}-${accent}";
      recursive = true;
      source = "${theme}/share/Kvantum/Catppuccin-${variant}-${accent}";
    };
  };

  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "kvantum";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_QPA_PLATFORM = "wayland";
  };
}
