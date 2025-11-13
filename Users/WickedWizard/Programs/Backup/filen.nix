{ pkgs, ... }:
{
  home.packages = with pkgs; [ filen-desktop ];

  programs.autostart.packages = with pkgs; [ filen-desktop ];
}
