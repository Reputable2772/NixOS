{ pkgs, lib, ... }: {
  home.pointerCursor = {
    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 16;

    gtk.enable = true;
    x11.enable = true;
  };

  dconf.settings."org/gnome/desktop/interface" = {
    cursor-theme = lib.mkForce "Catppuccin-Mocha-Dark-Cursors";
  };
}
