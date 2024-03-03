{ pkgs, lib, ... }:
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

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface" = {
      color-scheme = lib.mkForce "prefer-dark";
      cursor-theme = lib.mkForce "Nordic-cursors";
      gtk-theme = lib.mkForce "adw-gtk3-dark";
      icon-theme = lib.mkForce "MoreWaita";
    };
  };
}
