{ config, pkgs, ... }:
{
  # Qt applications are cool.
  # https://wiki.archlinux.org/title/Cursor_themes#Qt

  home.pointerCursor = {
    name = "catppuccin-mocha-dark-cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 32;

    gtk.enable = true;
    x11.enable = true;
  };

  # Needed for GTK apps.
  services.flatpak.overrides.global.Context = {
    filesystems = [
      "xdg-data/icons:ro"
    ];
  };

  # Pointing to the source path like this, is useless.
  # "${config.home.file.".icons/${config.home.pointerCursor.name}".source}"
  # This is because, flatpak seems to require the toplevel hm derivation,
  # as it is the first symlink to ~/.local/share/icons.
  systemd.user.services."flatpak-managed-install".Service = {
    # Needed so that all the flatpak overrides done manually in ExecStartPost don't clog up.
    ExecStartPre = pkgs.writeShellScript "reset-all-flatpak-overrides" "${pkgs.flatpak}/bin/flatpak --user override --reset";
    ExecStartPost = [
      (pkgs.writeShellScript "flatpak-gtk-cursor-themes" ''
        ${pkgs.flatpak}/bin/flatpak --user override --filesystem=$(readlink $HOME/.local/share/icons/${config.home.pointerCursor.name})
      '')
    ];
  };
}
