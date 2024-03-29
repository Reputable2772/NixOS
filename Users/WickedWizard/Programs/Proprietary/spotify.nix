{ pkgs, inputs, ... }:
let
  inherit (inputs) spicetify-nix;
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [
    spicetify-nix.homeManagerModule
  ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    enabledExtensions = with spicePkgs.extensions; [
      autoVolume
      adblock
      fullAppDisplay
      hidePodcasts
      shuffle
    ];
  };

  xdg.configFile."autostart/spicetify.desktop".source = "${pkgs.spotify}/share/applications/spotify.desktop";
}
