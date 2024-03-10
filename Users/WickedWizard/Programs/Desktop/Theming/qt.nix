{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum
    qt5.qtwayland
    qt6.qtwayland
    qt5ct
    kdePackages.qt6ct
  ];

  qt = {
    enable = true;
    platformTheme = "qtct";
    style.name = "kvantum";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    theme=Nordic-Darker-Solid
  '';

  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "kvantum";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_QPA_PLATFORM = "wayland";
  };
}
