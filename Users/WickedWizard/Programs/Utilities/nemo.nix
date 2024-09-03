{ pkgs, ... }: {
  # TODO: KDE Connect, Preview, GTKHash for Nemo.

  home.packages = with pkgs; [ nemo-with-extensions ];

  xdg.mimeApps.defaultApplications = {
    "inode/directory" = "nemo.desktop";
    "application/x-gnome-saved-search" = "nemo.desktop";
  };

  dconf.settings."org/nemo/preferences" = {
    executable-text-activation = "ask";
    quick-renames-with-pause-in-between = false;
    show-advanced-permissions = true;
  };

  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, E, exec, nemo"
  ];
}
