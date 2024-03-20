{
  home.username = "wickedwizard";
  home.homeDirectory = "/home/wickedwizard";

  # xdg.configFile."mimeapps.list".force = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "org.gnome.Evince.desktop";
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
      "application/zip" = "org.gnome.FileRoller.desktop";
      "text/plain" = "org.gnome.TextEditor.desktop";

      "application/xhtml+xml" = "librewolf.desktop";
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";

      "x-scheme-handler/sms" = "org.kde.kdeconnect.handler.desktop";
      "x-scheme-handler/tel" = "org.kde.kdeconnect.handler.desktop";

      "image/png" = "org.gnome.Loupe.desktop";
      "image/jpeg" = "org.gnome.Loupe.desktop";
      "image/gif" = "org.gnome.Loupe.desktop";
      "image/webp" = "org.gnome.Loupe.desktop";
      "image/tiff" = "org.gnome.Loupe.desktop";
      "image/x-tga" = "org.gnome.Loupe.desktop";
      "image/vnd-ms.dds" = "org.gnome.Loupe.desktop";
      "image/x-dds" = "org.gnome.Loupe.desktop";
      "image/bmp" = "org.gnome.Loupe.desktop";
      "image/vnd.microsoft.icon" = "org.gnome.Loupe.desktop";
      "image/vnd.radiance" = "org.gnome.Loupe.desktop";
      "image/x-exr" = "org.gnome.Loupe.desktop";
      "image/x-portable-bitmap" = "org.gnome.Loupe.desktop";
      "image/x-portable-graymap" = "org.gnome.Loupe.desktop";
      "image/x-portable-pixmap" = "org.gnome.Loupe.desktop";
      "image/x-portable-anymap" = "org.gnome.Loupe.desktop";
      "image/x-qoi" = "org.gnome.Loupe.desktop";
      "image/svg+xml" = "org.gnome.Loupe.desktop";
      "image/svg+xml-compressed" = "org.gnome.Loupe.desktop";
      "image/avif" = "org.gnome.Loupe.desktop";
      "image/heic" = "org.gnome.Loupe.desktop";
      "image/jxl" = "org.gnome.Loupe.desktop";

      "inode/directory" = "thunar.desktop";
    };
  };

  imports = [
    ./Programs
    ./Services
  ];

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
