{
  # Don't upgrade evince to papers. It doesn't have a resizable left bar.
  services.flatpak.packages = [ "org.gnome.Evince" ];

  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "org.gnome.Evince";
  };

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
}
