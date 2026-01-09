{ config, pkgs, ... }:
{
  services.flatpak.packages = [ "re.sonny.Junction" ];

  systemd.user.services."flatpak-managed-install".Service = {
    ExecStartPost = [
      (pkgs.writeShellScript "flatpak-junction-overrides" ''
        rm -rf ${config.home.homeDirectory}/.local/share/applications
        ln -s ${config.home.homeDirectory}/.nix-profile/share/applications ${config.home.homeDirectory}/.local/share/
      '')
    ];
  };

  # Already assigned to programs.mimeApps.priority.
  xdg.mimeApps.defaultApplications = {
    "default-web-browser" = [ "re.sonny.Junction.desktop" ];
    "text/html" = [ "re.sonny.Junction.desktop" ];
    "x-scheme-handler/http" = [ "re.sonny.Junction.desktop" ];
    "x-scheme-handler/https" = [ "re.sonny.Junction.desktop" ];
    "x-scheme-handler/about" = [ "re.sonny.Junction.desktop" ];
    "x-scheme-handler/unknown" = [ "re.sonny.Junction.desktop" ];
    "x-scheme-handler/junction" = [ "re.sonny.Junction.desktop" ];
  };

  wayland.windowManager.hyprland.settings.windowrule = [
    "match:class (re.sonny.Junction), tag +dialog"
  ];
}
