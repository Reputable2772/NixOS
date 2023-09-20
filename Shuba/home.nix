{ config, pkgs, ... }:
{
  home.username = "shuba";
  home.homeDirectory = "/home/shuba";
  home.packages = with pkgs; [
    firefox
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect
    librewolf
    skypeforlinux
    whatsapp-for-linux
  ];

  # imports = [ ./gnome.nix ];

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
