{ pkgs, ... }:
{
  home.packages = with pkgs; [ evince ];

  dconf.settings."org/gnome/evince/default" = {
    continuous = true;
    dual-page = false;
    dual-page-odd-left = false;
    enable-spellchecking = true;
    fullscreen = false;
    inverted-colors = true;
    show-sidebar = true;
    sidebar-page = "thumbnails";
    sidebar-size = 194;
    sizing-mode = "fit-width";
  };

  xdg.mimeApps.defaultApplications = {
    "application/vnd.comicbook-rar" = "org.gnome.Evince.desktop";
    "application/vnd.comicbook+zip" = "org.gnome.Evince.desktop";
    "application/x-cb7" = "org.gnome.Evince.desktop";
    "application/x-cbr" = "org.gnome.Evince.desktop";
    "application/x-cbt" = "org.gnome.Evince.desktop";
    "application/x-cbz" = "org.gnome.Evince.desktop";
    "application/x-ext-cb7" = "org.gnome.Evince.desktop";
    "application/x-ext-cbr" = "org.gnome.Evince.desktop";
    "application/x-ext-cbt" = "org.gnome.Evince.desktop";
    "application/x-ext-cbz" = "org.gnome.Evince.desktop";
    "application/x-ext-djv" = "org.gnome.Evince.desktop";
    "application/x-ext-djvu" = "org.gnome.Evince.desktop";
    "image/vnd.djvu" = "org.gnome.Evince.desktop";
    "application/x-bzdvi" = "org.gnome.Evince.desktop";
    "application/x-dvi" = "org.gnome.Evince.desktop";
    "application/x-ext-dvi" = "org.gnome.Evince.desktop";
    "application/x-gzdvi" = "org.gnome.Evince.desktop";
    "application/pdf" = "org.gnome.Evince.desktop";
    "application/x-bzpdf" = "org.gnome.Evince.desktop";
    "application/x-ext-pdf" = "org.gnome.Evince.desktop";
    "application/x-gzpdf" = "org.gnome.Evince.desktop";
    "application/x-xzpdf" = "org.gnome.Evince.desktop";
    "application/postscript" = "org.gnome.Evince.desktop";
    "application/x-bzpostscript" = "org.gnome.Evince.desktop";
    "application/x-gzpostscript" = "org.gnome.Evince.desktop";
    "application/x-ext-eps" = "org.gnome.Evince.desktop";
    "application/x-ext-ps" = "org.gnome.Evince.desktop";
    "image/x-bzeps" = "org.gnome.Evince.desktop";
    "image/x-eps" = "org.gnome.Evince.desktop";
    "image/x-gzeps" = "org.gnome.Evince.desktop";
    "image/tiff" = "org.gnome.Evince.desktop";
    "application/oxps" = "org.gnome.Evince.desktop";
    "application/vnd.ms-xpsdocument" = "org.gnome.Evince.desktop";
    "application/illustrator" = "org.gnome.Evince.desktop";
  };
}
