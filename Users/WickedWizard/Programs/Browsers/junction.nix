{
  services.flatpak.packages = [ "re.sonny.Junction" ];

  xdg.mimeApps.defaultApplications = {
    "default-web-browser" = [ "re.sonny.Junction.desktop" ];
    "text/html" = [ "re.sonny.Junction.desktop" ];
    "x-scheme-handler/http" = [ "re.sonny.Junction.desktop" ];
    "x-scheme-handler/https" = [ "re.sonny.Junction.desktop" ];
    "x-scheme-handler/about" = [ "re.sonny.Junction.desktop" ];
    "x-scheme-handler/unknown" = [ "re.sonny.Junction.desktop" ];
  };

  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "tag +dialog, class:(re.sonny.Junction)"
  ];
}
