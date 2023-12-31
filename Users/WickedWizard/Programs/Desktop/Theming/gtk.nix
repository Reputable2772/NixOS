{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    adw-gtk3
  ];

  gtk = {
    enable = true;
    gtk4.extraCss = builtins.readFile ./CSS/gtk4.css;
    gtk3.extraCss = builtins.readFile ./CSS/gtk4.css;
    iconTheme = {
      name = "MoreWaita";
      package = pkgs.nur.repos.federicoschonborn.morewaita;
    };
  };

  dconf.settings."org/gnome/desktop/interface" = {
    gtk-theme = "adw-gtk3-dark";
  };
}
