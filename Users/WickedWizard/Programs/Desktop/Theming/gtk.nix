{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    adw-gtk3
    gradience
  ];

  gtk = {
    enable = true;
    # gtk4.extraCss = builtins.readFile ./CSS/gtk4.css;
    # gtk3.extraCss = builtins.readFile ./CSS/gtk4.css;
    iconTheme = {
      name = "MoreWaita";
      package = pkgs.morewaita-icon-theme;
    };
  };

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    cursor-theme = "Nordic-cursors";
    gtk-theme = "adw-gtk3-dark";
    icon-theme = "MoreWaita";
  };
}
