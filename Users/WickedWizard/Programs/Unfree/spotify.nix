{ config, pkgs, inputs, ... }:
let
  inherit (inputs) spicetify-nix;
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [
    spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
    windowManagerPatch = config.wayland.windowManager.hyprland.enable;

    enabledExtensions = with spicePkgs.extensions; [
      autoVolume
      adblock
      fullAppDisplay
      hidePodcasts
      shuffle
    ];
  };

  programs.autostart.packages = with pkgs; [ spotify ];
}
