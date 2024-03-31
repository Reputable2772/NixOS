{ pkgs, ... }:
{
  home.packages = with pkgs; [ beeper ];

  programs.autostart.autostartPackages = with pkgs; [ beeper ];
}
