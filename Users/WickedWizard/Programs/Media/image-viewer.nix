{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.flatpak.packages = lib.optional (!config.programs.plasma.enable) "org.gnome.Loupe";
  programs.mimeApps.flatpaks = lib.optional (!config.programs.plasma.enable) "org.gnome.Loupe";

  home.packages = lib.optional config.programs.plasma.enable pkgs.kdePackages.gwenview;
  programs.mimeApps.packages = lib.optional config.programs.plasma.enable pkgs.kdePackages.gwenview;
}
