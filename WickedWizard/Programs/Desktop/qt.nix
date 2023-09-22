{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    qt5.qtwayland
    qt6.qtwayland
    qt5ct
    qt6ct
  ];

  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "kvantum";
    QT_QPA_PLATFORMTHEME = lib.mkForce "qt5ct";
    QT_QPA_PLATFORM = "wayland";
  };
}
