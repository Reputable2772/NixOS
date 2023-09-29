{ config, pkgs, lib, ... }:
{
  home.username = "wickedwizard";
  home.homeDirectory = "/home/wickedwizard";

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "org.gnome.Evince.desktop";
      "application/zip" = "org.gnome.FileRoller.desktop";
      "text/plain" = "org.gnome.TextEditor.desktop";
      "x-scheme-handler/sms" = "org.gnome.Shell.Extensions.GSConnect.desktop";
      "x-scheme-handler/tel" = "org.gnome.Shell.Extensions.GSConnect.desktop";
      "image/png" = "org.gnome.eog.desktop";
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
    };
  };

  imports = [
    ./Programs
  ];

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
