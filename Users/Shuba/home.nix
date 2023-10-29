{ config, pkgs, ... }:
{
  home.username = "shuba";
  home.homeDirectory = "/home/shuba";
  home.packages = with pkgs; [
    firefox
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect
    gnomeExtensions.clipboard-indicator
    librewolf
    libreoffice
    vlc
    quickemu
    deluge-gtk
    whatsapp-for-linux
    skypeforlinux
    kitty
  ];

  xdg.configFile."autostart/skypeforlinux.desktop".source = "${pkgs.skypeforlinux}/share/applications/skypeforlinux.desktop";
  xdg.configFile."autostart/whatsapp-for-linux.desktop".source = "${pkgs.whatsapp-for-linux}/share/applications/whatsapp-for-linux.desktop";
  xdg.configFile."autostart/librewolf.desktop".source = "${pkgs.librewolf}/share/applications/librewolf.desktop";

  imports = [ ./gnome.nix ];

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
