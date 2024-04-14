{ config, osConfig, lib, pkgs, ... }:
let
  firefox-gnome-theme = pkgs.callPackage ../../../../Packages/firefox-gnome-theme.nix { };
  # Get path of a with respect to b
  absoluteToRelative = _a: _b:
    with lib;
    let
      # Remove trailing '/'
      a = removeSuffix "/" _a;
      b = removeSuffix "/" _b;

      # Split strings at '/' to form a list
      splitA = splitString "/" a;
      splitB = splitString "/" b;

      # Get number of common elements in A and B.
      c = length (lists.commonPrefix splitA splitB);

      # Number of directories to go back from B to reach common directory for A and B.
      backLength = length splitB - c;
      # Get path from common directory.
      forwardPath = drop c splitA;
      path = (if backLength < 1 then "./" else "") + strings.replicate backLength "../" + concatMapStrings (s: s + "/") forwardPath;
    in
    path;
in
{
  home.packages = [ firefox-gnome-theme ];
  programs.firefox = {
    enable = true;
    profiles."default" = {
      isDefault = true;
      name = "default";
      path = absoluteToRelative "${osConfig.programs.config_dir.browser_dir}/Firefox/" "${config.home.homeDirectory}/.mozilla/firefox/";
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
