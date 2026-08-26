{
  config,
  config',
  lib',
  pkgs,
  lib,
  sources,
  ...
}:
# Try converting to Flatpak. Seems improbable for now.
let
  firefox-gnome-theme = pkgs.callPackage ../../../../Packages/firefox-gnome-theme.nix {
    inherit sources;
  };
in
{
  stylix.targets.firefox.enable = false;
  programs.firefox = {
    enable = true;
    profiles."default" = {
      isDefault = true;
      name = "default";
      path = lib.mkIf (config'.dir ? browsers) (
        lib'.absoluteToRelativePath "${config'.dir.browsers}/Firefox/" "${config.home.homeDirectory}/.mozilla/firefox/"
      );
      userChrome = ''
        @import "${firefox-gnome-theme}/share/firefox-gnome-theme/userChrome.css";
      '';
      userContent = ''
        @import "${firefox-gnome-theme}/share/firefox-gnome-theme/userContent.css";
      '';
      extraConfig = builtins.readFile "${firefox-gnome-theme}/share/firefox-gnome-theme/configuration/user.js";
    };
  };

  # xdg.autostart.packages = with pkgs; [ firefox ];

  programs.nvfetcher.config.firefox-gnome-theme = {
    src.github = "rafaelmardojai/firefox-gnome-theme";
    fetch.github = "rafaelmardojai/firefox-gnome-theme";
  };

  wayland.windowManager.hyprland.settings = {
    # bind = [
    #   "SUPER, V, exec, firefox"
    # ];
    windowrule = [
      "match:initial_class (firefox), workspace 1"
    ];
  };
}
