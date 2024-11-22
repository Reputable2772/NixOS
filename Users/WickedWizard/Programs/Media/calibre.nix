{ pkgs, sources, inputs, ... }:
let
  catppuccin-calibre = pkgs.callPackage ../../../../Packages/calibre-catppuccin.nix { inherit sources; };
in
{
  home.packages = [ inputs.nixpkgs-stable.legacyPackages.${pkgs.system}.calibre ];

  xdg.mimeApps.defaultApplications = {
    "image/vnd.djvu" = "calibre-ebook-viewer.desktop";
    "application/oebps-package+xml" = "calibre-ebook-viewer.desktop";
    "application/vnd.oasis.opendocument.text" = "calibre-ebook-viewer.desktop";
    "application/x-mobipocket-subscription" = "calibre-ebook-viewer.desktop";
    "application/x-cbc" = "calibre-ebook-viewer.desktop";
    "application/x-mobi8-ebook" = "calibre-ebook-viewer.desktop";
    "application/epub+zip" = "calibre-ebook-viewer.desktop";
    "application/x-cbz" = "calibre-ebook-viewer.desktop";
    "application/x-sony-bbeb" = "calibre-ebook-viewer.desktop";
    "application/x-cb7" = "calibre-ebook-viewer.desktop";
    "text/fb2+xml" = "calibre-ebook-viewer.desktop";
    "application/x-mobipocket-ebook" = "calibre-ebook-viewer.desktop";
    "application/x-cbr" = "calibre-ebook-viewer.desktop";
    "application/ereader" = "calibre-ebook-viewer.desktop";
  };

  xdg.configFile."calibre/resources/images".source = catppuccin-calibre.mocha.outPath;
  /**
    TODO: Use home.activation to check whether the JSON of ~/.config/calibre/gui.json has
    the JSON contained by the theme files.

    Currently too much effort.
   */
}
