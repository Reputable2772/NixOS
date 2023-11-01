{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    gradience
    adw-gtk3
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Nordic-darker";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "MoreWaita";
      package = pkgs.nur.repos.federicoschonborn.morewaita;
    };
  };
}
