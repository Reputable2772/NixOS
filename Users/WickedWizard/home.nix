{ config, pkgs, lib, ... }:
{
  home.username = "wickedwizard";
  home.homeDirectory = "/home/wickedwizard";

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "x-scheme-handler/sms" = "org.gnome.Shell.Extensions.GSConnect.desktop";
      "x-scheme-handler/tel" = "org.gnome.Shell.Extensions.GSConnect.desktop";
      "image/jpeg" = "org.gnome.eog.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "text/html" = "librewolf.desktop";
      "application/xhtml+xml" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
    };
    defaultApplications = {
      "application/pdf" = "org.gnome.Evince.desktop";
      "application/zip" = "org.gnome.FileRoller.desktop";
      "text/plain" = "org.gnome.TextEditor.desktop";
      "x-scheme-handler/sms" = "org.gnome.Shell.Extensions.GSConnect.desktop";
      "x-scheme-handler/tel" = "org.gnome.Shell.Extensions.GSConnect.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "text/html" = "librewolf.desktop";
      "application/xhtml+xml" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "image/png" = "org.gnome.eog.desktop";
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
    };
  };

  imports = [
    ./Programs
    ./Services
  ];

  services.flatpak = {
    enableModule = true;
    packages = [ "flathub:app/io.freetubeapp.FreeTube//stable" "flathub:app/com.ranfdev.Notify//stable" "flathub:app/com.github.alainm23.planner//stable" ];
    remotes = {
      "flathub" = "https://flathub.org/repo/flathub.flatpakrepo";
    };
  };

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
