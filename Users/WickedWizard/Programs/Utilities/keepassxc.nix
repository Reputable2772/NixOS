{ pkgs, ... }:
{
  home.packages = with pkgs; [ keepassxc ];

  programs.autostart.packages = with pkgs; [ keepassxc ];
}
