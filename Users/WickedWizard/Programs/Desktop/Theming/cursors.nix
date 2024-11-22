{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Qt applications are cool.
  # https://wiki.archlinux.org/title/Cursor_themes#Qt

  home.pointerCursor = {
    name = "catppuccin-mocha-dark-cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 16;

    gtk.enable = true;
    x11.enable = true;
  };

  # gtk.cursorTheme is explicitly set by home.pointerCursor once home.pointerCursor.gtk.enable is enabled.
  dconf.settings."org/gnome/desktop/interface" = {
    cursor-theme = lib.mkForce config.gtk.cursorTheme.name;
    cursor-size = lib.mkForce config.gtk.cursorTheme.size;
  };
}
