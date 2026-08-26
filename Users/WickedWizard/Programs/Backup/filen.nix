{ pkgs, ... }:
{
  home.packages = with pkgs; [ filen-desktop ];

  xdg.autostart.packages = with pkgs; [ filen-desktop ];
}
