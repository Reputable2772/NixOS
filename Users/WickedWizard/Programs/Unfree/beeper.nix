{ pkgs, ... }:
{
  home.packages = with pkgs; [ beeper ];

  programs.autostart.packages = with pkgs; [ beeper ];
}
