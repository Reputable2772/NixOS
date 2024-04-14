{ config, osConfig, lib, pkgs, ... }:
let
  firefox-gnome-theme = pkgs.callPackage ../../../../Packages/firefox-gnome-theme.nix { };
  # Get path of a with respect to b.
  # This onlyl works for paths beginning with /home/something/
  # You can change the numbers for it to work with other paths
  # The numbers indicate how many parts of the two paths are identical.
  absoluteToRelative = _a: _b: c:
    let
      # Remove trailing '/'
      a = lib.strings.removeSuffix "/" _a;
      b = lib.strings.removeSuffix "/" _b;

      # Get length of path b
      length = lib.lists.length (lib.strings.splitString "/" b) - c;
      # Drop the paths that are identical in a
      drop = lib.drop c (lib.strings.splitString "/" (lib.strings.removeSuffix "/" a));
      path = lib.strings.replicate length "../" + lib.concatMapStrings (s: s + "/") drop;
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
      path = absoluteToRelative "${osConfig.programs.config_dir.browser_dir}/Firefox/" "${config.home.homeDirectory}/.mozilla/firefox/" 3;
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
