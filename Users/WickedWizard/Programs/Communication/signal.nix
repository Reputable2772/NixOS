{ pkgs, ... }:
{
  home.packages = with pkgs; [ signal-desktop ];

  # programs.autostart.packages = with pkgs; [ signal-desktop ];
}
