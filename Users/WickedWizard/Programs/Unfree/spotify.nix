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

  /**
    This is a modification of https://github.com/Gerg-L/spicetify-nix/blob/master/pkgs/spicetifyBuilder.nix
    to use the declarative handling of dependencies done by the module, but modifying it such that
    it is usable as a flatpak.

    It copies over all the required build directories for spicetify, and changes locations to point
    to the flatpak.
   */
  xdg.configFile.spicetify = {
    enable = config.programs.spicetify.dontInstall;
    recursive = true;
    source = "${config.programs.spicetify.spicedSpotify.overrideAttrs (old: {
      # ; is required since the string is terminated in the same line, in upstream.
      postInstall = (old.postInstall or "") + ''
        ;mkdir -p $out/src $out/src/Backup
        cp -r {Themes,Extensions,CustomApps} $out/src
        cp -ra {jsHelper,css-map.json} $out/src

        sed "s|${
          if pkgs.stdenv.isLinux then
            "$out/share/spotify"
          else if pkgs.stdenv.isDarwin then
            "$out/Applications/Spotify.app/Contents/Resources"
          else
            throw ""
        }|${config.xdg.dataHome}/flatpak/app/com.spotify.Client/current/active/files/extra/share/spotify|g; s|$SPICETIFY_CONFIG/prefs|${config.home.homeDirectory}/.var/app/com.spotify.Client/config/spotify/prefs|g" config-xpui.ini > $out/src/config-xpui.ini
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
