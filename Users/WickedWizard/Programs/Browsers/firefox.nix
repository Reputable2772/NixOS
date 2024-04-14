{ pkgs, ... }:
let
  firefox-gnome-theme = pkgs.callPackage ../../../../Packages/firefox-gnome-theme.nix { };
in
{
  disabledModules = [ "programs/firefox.nix" ];

  home.packages = [ firefox-gnome-theme ];
  programs.firefox = {
    enable = true;
    profiles."default" = {
      isDefault = true;
      name = "default";
      isRelative = 0;
      # This needs to be relative since Firefox doesn't support absolute paths without the `isRelative` flag.
      path = "../../Documents/Browsers/Firefox/";
      userChrome = ''
        @import "${firefox-gnome-theme}/share/firefox-gnome-theme/userChrome.css";
      '';
      userContent = ''
        @import "${firefox-gnome-theme}/share/firefox-gnome-theme/userContent.css";
      '';
      extraConfig = builtins.readFile "${firefox-gnome-theme}/share/firefox-gnome-theme/configuration/user.js";
    };
  };

  # programs.autostart.autostartPackages = with pkgs; [ firefox ];

  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, V, exec, firefox"
  ];
}
