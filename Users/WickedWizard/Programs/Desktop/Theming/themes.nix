{ pkgs, ... }:
{
  home.sessionVariables.QT_QPA_PLATFORMTHEME = "qt5ct";

  home.packages = with pkgs; [
    # Set theme here. It is not declarative.
    libsForQt5.qt5ct
    kdePackages.qt6ct

    # kdePackages.breeze
    libsForQt5.breeze-qt5
  ];

  # GTK4 applications
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
  };

  # GTK3 applications
  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
}
