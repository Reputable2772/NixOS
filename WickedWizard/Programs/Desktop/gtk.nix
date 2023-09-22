{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    gradience
  ];

  gtk = {
    enable = true;
    theme.name = "Nordic-darker";
    theme.package = pkgs.nordic;
  };
}
