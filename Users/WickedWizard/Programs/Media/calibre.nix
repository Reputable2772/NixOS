{ pkgs, sources, ... }:
let
  catppuccin-calibre = pkgs.callPackage ../../../../Packages/calibre-catppuccin.nix { inherit sources; };
in
{
  home.packages = with pkgs; [ calibre ];

  xdg.mimeApps.defaultApplications = {
    "image/vnd.djvu" = "calibre-ebook-viewer.desktop";
    "application/oebps-package+xml" = "calibre-ebook-viewer.desktop";
    "application/vnd.oasis.opendocument.text" = "calibre-ebook-viewer.desktop";
    "text/rtf" = "calibre-ebook-viewer.desktop";
    "application/x-mobipocket-subscription" = "calibre-ebook-viewer.desktop";
    "application/x-cbc" = "calibre-ebook-viewer.desktop";
    "application/vnd.ms-word.document.macroenabled.12" = "calibre-ebook-viewer.desktop";
    "application/x-mobi8-ebook" = "calibre-ebook-viewer.desktop";
    "application/epub+zip" = "calibre-ebook-viewer.desktop";
    "application/x-cbz" = "calibre-ebook-viewer.desktop";
    "application/x-sony-bbeb" = "calibre-ebook-viewer.desktop";
    "text/x-markdown" = "calibre-ebook-viewer.desktop";
    "text/html" = "calibre-ebook-viewer.desktop";
    "text/plain" = "calibre-ebook-viewer.desktop";
    "application/x-cb7" = "calibre-ebook-viewer.desktop";
    "application/pdf" = "calibre-ebook-viewer.desktop";
    "application/xhtml+xml" = "calibre-ebook-viewer.desktop";
    "text/fb2+xml" = "calibre-ebook-viewer.desktop";
    "application/x-mobipocket-ebook" = "calibre-ebook-viewer.desktop";
    "application/x-cbr" = "calibre-ebook-viewer.desktop";
    "application/ereader" = "calibre-ebook-viewer.desktop";
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "calibre-ebook-viewer.desktop";
  };

  xdg.configFile."calibre/resources/images".source = catppuccin-calibre.mocha.outPath;
  /**
    TODO: Use home.activation to check whether the JSON of ~/.config/calibre/gui.json has
    the JSON contained by the theme files.

    Currently too much effort.
   */
}
