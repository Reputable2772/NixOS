{ config, config', lib', pkgs, lib, sources, ... }:
let
  firefox-gnome-theme = pkgs.callPackage ../../../../Packages/firefox-gnome-theme.nix { inherit sources; };
in
{
  home.packages = [ firefox-gnome-theme ];
  programs.firefox = {
    enable = true;
    profiles."default" = {
      isDefault = true;
      name = "default";
      path = lib.mkIf
        (config'.dir ? browsers)
        (lib'.absoluteToRelativePath "${config'.dir.browsers}/Firefox/" "${config.home.homeDirectory}/.mozilla/firefox/");
      userChrome = ''
        @import "${firefox-gnome-theme}/share/firefox-gnome-theme/userChrome.css";
      '';
      userContent = ''
        @import "${firefox-gnome-theme}/share/firefox-gnome-theme/userContent.css";
      '';
      extraConfig = builtins.readFile "${firefox-gnome-theme}/share/firefox-gnome-theme/configuration/user.js";
    };
  };

  programs.autostart.packages = with pkgs; [ firefox ];

  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, V, exec, firefox"
  ];
}
