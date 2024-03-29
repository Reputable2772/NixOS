# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "com/github/wwmm/easyeffects" = {
      last-used-input-preset = "Presets";
      last-used-output-preset = "Presets";
      window-fullscreen = false;
      window-height = 519;
      window-maximized = true;
      window-width = 960;
    };

    "com/github/wwmm/easyeffects/streaminputs" = {
      input-device = "alsa_input.pci-0000_04_00.6.analog-stereo";
    };

    "com/github/wwmm/easyeffects/streamoutputs" = {
      blocklist = [ ];
      output-device = "bluez_output.41_42_4C_5C_BB_63.1";
    };

    "org/gnome/Fractal/Stable" = {
      current-session = "85cd8322-bace-427a-a816-98d74e3aa12e";
      is-maximized = true;
      markdown-enabled = true;
      sessions = "[[\"85cd8322-bace-427a-a816-98d74e3aa12e\",{}]]";
      window-height = 602;
      window-width = 763;
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-size = 16;
      cursor-theme = "Nordic-cursors";
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      gtk-theme = "Catppuccin-Mocha-Standard-Blue-Dark";
      icon-theme = "Adwaita";
    };

    "org/gnome/evince/default" = {
      continuous = true;
      dual-page = false;
      dual-page-odd-left = false;
      enable-spellchecking = true;
      fullscreen = false;
      inverted-colors = true;
      show-sidebar = true;
      sidebar-page = "thumbnails";
      sidebar-size = 194;
      sizing-mode = "fit-width";
      window-ratio = mkTuple [ 0.980392 0.757576 ];
    };

    "org/gnome/file-roller/listing" = {
      list-mode = "as-folder";
      name-column-width = 250;
      show-path = false;
      sort-method = "name";
      sort-type = "ascending";
    };

    "org/gnome/file-roller/ui" = {
      sidebar-width = 200;
      window-height = 948;
      window-width = 1878;
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 179;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [ 0 0 ];
      window-size = mkTuple [ 1231 902 ];
    };

  };
}
