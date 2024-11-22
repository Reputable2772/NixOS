{
  config,
  pkgs,
  lib,
  ...
}:
{
  # TODO: KDE Connect, Preview, GTKHash for Nemo.

  home.packages = lib.optional config.wayland.windowManager.hyprland.enable pkgs.nemo-with-extensions;

  xdg.mimeApps.defaultApplications = lib.mkIf config.wayland.windowManager.hyprland.enable {
    "inode/directory" = "nemo.desktop";
    "application/x-gnome-saved-search" = "nemo.desktop";
  };

  dconf.settings."org/nemo/preferences" = lib.mkIf config.wayland.windowManager.hyprland.enable {
    executable-text-activation = "ask";
    quick-renames-with-pause-in-between = false;
    show-advanced-permissions = true;
  };

  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, E, exec, nemo"
  ];
}
