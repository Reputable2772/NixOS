{ pkgs, ... }:
{
  services.flatpak.packages = [ "re.sonny.Junction" ];

  systemd.user.services."flatpak-managed-install".Service = {
    ExecStartPost = [
      (pkgs.writeShellScript "flatpak-junction-overrides" ''
        # Allow XDG_DATA_DIRS entirely, with sandbox overrides from https://github.com/flatpak/flatpak/blob/main/common/flatpak-run.c#L552

        ${pkgs.flatpak}/bin/flatpak --user override --env=XDG_DATA_DIRS="/app/share:/usr/share:$XDG_DATA_DIRS" re.sonny.Junction
        for path in $(echo $XDG_DATA_DIRS | ${pkgs.coreutils-full}/bin/tr ':' '\n'); do
          ${pkgs.flatpak}/bin/flatpak --user override --filesystem="$path" re.sonny.Junction
        done
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

  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "tag +dialog, class:(re.sonny.Junction)"
  ];
}
