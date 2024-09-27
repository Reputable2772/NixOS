{ config, pkgs, lib, inputs, ... }:
let
  inherit (inputs) spicetify-nix;
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  services.flatpak.packages = lib.optional config.programs.spicetify.dontInstall "com.spotify.Client";

  imports = [
    spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = true;
    # Set to true to use flatpak installation.
    dontInstall = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
    alwaysEnableDevTools = true;
    # Flatpak takes care of this.
    windowManagerPatch = config.wayland.windowManager.hyprland.enable && !config.programs.spicetify.dontInstall;

    enabledExtensions = with spicePkgs.extensions; [
      autoVolume
      adblock
      fullAppDisplay
      hidePodcasts
      shuffle
    ];
  };

  # This is taken from https://github.com/Gerg-L/spicetify-nix/blob/master/pkgs/spicetify.nix
  # to modify ~/.config/spicetify to be declarative, while simultaneously being able to
  # be modded by spicetify.
  xdg.configFile.spicetify = {
    enable = config.programs.spicetify.dontInstall;
    recursive = true;
    source = "${config.programs.spicetify.spicedSpotify.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        mkdir -p $out/src $out/src/Backup
        cp -r {Themes,Extensions,CustomApps} $out/src

        ln -s ${pkgs.spicetify-cli}/bin/jsHelper $out/src/jsHelper
        ln -s ${pkgs.spicetify-cli.src}/css-map.json $out/src/css-map.json

        sed "s|__SPOTIFY__|${config.xdg.dataHome}/flatpak/app/com.spotify.Client/current/active/files/extra/share/spotify|g; s|__PREFS__|${config.home.homeDirectory}/.var/app/com.spotify.Client/config/spotify/prefs|g" ${
          pkgs.writeText "spicetify-confi-xpui" (lib.generators.toINI { } config.programs.spicetify.spicedSpotify.config-xpui)
        } > $out/src/config-xpui.ini
      '';
    })}/src";
  };

  programs.autostart.packages = [
    (if config.programs.spicetify.dontInstall then
      (pkgs.makeDesktopItem {
        name = "Spotify";
        exec = "flatpak run com.spotify.Client";
        desktopName = "spotify";
        categories = [ "Applications" ];
      })
    else
      pkgs.spotify)
  ];

  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "workspace 5, initialClass:(Spotify)"
  ];
}
