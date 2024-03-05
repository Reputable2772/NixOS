{ config, pkgs, inputs, ... }:
{
  programs.gamemode.enable = true;
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    gitFull
    curl
    nano
  ];

  # Thunar Only
  programs.thunar.enable = config.programs.hyprland.enable;
  programs.xfconf.enable = config.programs.hyprland.enable;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.gvfs.enable = config.programs.hyprland.enable; # Mount, trash, and other functionalities
  services.tumbler.enable = config.programs.hyprland.enable; # Thumbnail support for images
}
