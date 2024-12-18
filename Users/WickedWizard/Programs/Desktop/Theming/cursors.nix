{ pkgs, ... }:
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
}
