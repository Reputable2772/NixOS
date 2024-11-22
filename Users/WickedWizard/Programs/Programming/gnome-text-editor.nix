{ pkgs, ... }:
{
  home.packages = with pkgs; [ gnome-text-editor ];
}
