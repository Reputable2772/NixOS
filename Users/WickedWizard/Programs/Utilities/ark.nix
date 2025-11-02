{ pkgs, ... }:
{
  home.packages = with pkgs; [ kdePackages.ark ];
  programs.mimeApps.packages = with pkgs; [ kdePackages.ark ];
}
