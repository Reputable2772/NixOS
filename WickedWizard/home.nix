{ config, pkgs, lib, ... }:
{
  home.username = "wickedwizard";
  home.homeDirectory = "/home/wickedwizard";
  home.packages = with pkgs; [
    bottom
    calibre
    libsecret
    dnsutils
    dconf2nix
    easyeffects
    eza
    gocryptfs
    gradience
    neofetch
    libsForQt5.qtstyleplugin-kvantum
    lazygit
    qt5.qtwayland
    qt6.qtwayland
    nheko
    rmtrash
    rclone
    transmission-gtk
    vlc

    podman-compose

    qt5ct
    qt6ct

    ## Gnome
    gnomeExtensions.appindicator
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.gsconnect
    gnomeExtensions.bluetooth-battery
    gnomeExtensions.gamemode
  ];

  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "kvantum";
    QT_QPA_PLATFORMTHEME = lib.mkForce "qt5ct";
    QT_QPA_PLATFORM = "wayland";
  };

  gtk = {
    enable = true;
    theme.name = "Nordic-darker";
    theme.package = pkgs.nordic;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "org.gnome.Evince.desktop";
      "x-scheme-handler/sms" = "org.gnome.Shell.Extensions.GSConnect.desktop";
      "x-scheme-handler/tel" = "org.gnome.Shell.Extensions.GSConnect.desktop";
    };
  };

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;

  imports = [
    ./Programs
  ];
}
