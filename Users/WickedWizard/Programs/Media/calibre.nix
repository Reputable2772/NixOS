{ pkgs, sources, ... }:
let
  catppuccin-calibre = (pkgs.callPackage ../../../../Packages/calibre-catppuccin.nix { inherit sources; });
in
{
  home.packages = with pkgs; [ calibre ];

  xdg.configFile."calibre/resources/images".source = catppuccin-calibre.mocha.outPath;
  /**
    TODO: Use home.activation to check whether the JSON of ~/.config/calibre/gui.json has
    the JSON contained by the theme files.

    Currently too much effort.
   */
}
