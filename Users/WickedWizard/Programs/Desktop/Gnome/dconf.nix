# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "apps/seahorse/listing" = {
      item-filter = "any";
      keyrings-selected = [ "gnupg://" ];
    };

    "apps/seahorse/windows/key-manager" = {
      height = 991;
      width = 1878;
    };

    "com/github/wwmm/easyeffects" = {
      last-used-input-preset = "Presets";
      last-used-output-preset = "Presets";
      window-fullscreen = false;
      window-height = 429;
      window-maximized = true;
      window-width = 749;
    };

    "com/github/wwmm/easyeffects/streaminputs" = {
      input-device = "alsa_input.pci-0000_04_00.6.analog-stereo";
    };

    "com/github/wwmm/easyeffects/streamoutputs" = {
      output-device = "bluez_output.41_42_4C_5C_BB_63.1";
    };

    "org/gnome/Fractal/Stable" = {
      current-session = "7ecb27dd-f8c4-400c-8956-2d488cac633d";
      is-maximized = true;
      markdown-enabled = true;
      sessions = "[[\"7ecb27dd-f8c4-400c-8956-2d488cac633d\",{}]]";
      window-height = 602;
      window-width = 763;
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Nordic-cursors";
      gtk-theme = "adw-gtk3-dark";
      icon-theme = "MoreWaita";
    };

    "org/gnome/desktop/notifications/application/com-belmoussaoui-authenticator" = {
      application-id = "com.belmoussaoui.Authenticator.desktop";
    };

    "org/gnome/desktop/notifications/application/vesktop" = {
      application-id = "vesktop.desktop";
    };

    "org/gnome/desktop/notifications/application/vlc" = {
      application-id = "vlc.desktop";
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
      sidebar-size = 132;
      sizing-mode = "fit-width";
      window-ratio = mkTuple [ 1.615126050420168 0.25771971496437057 ];
      zoom = 1.1182024759006512;
    };

    "org/gnome/file-roller/dialogs/extract" = {
      recreate-folders = true;
      skip-newer = false;
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
      window-height = 991;
      window-width = 1878;
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [ 890 550 ];
      maximized = true;
    };

    "org/gnome/portal/filechooser/kitty" = {
      last-folder-path = "/home/wickedwizard/Downloads";
    };

    "org/gnome/portal/filechooser/org/gnome/Settings" = {
      last-folder-path = "/home/wickedwizard/Documents/Applications/Containers/Lidarr";
    };

    "org/gtk/gtk4/settings/emoji-chooser" = {
      recent-emoji = [ (mkTuple [ (mkTuple [ [ (mkUint32 128517) ] "grinning face with sweat" [ "cold" "face" "open" "smile" "sweat" ] (mkUint32 0) ]) (mkUint32 0) ]) ];
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 203;
      sort-column = "modified";
      sort-directories-first = false;
      sort-order = "descending";
      type-format = "category";
      window-position = mkTuple [ 0 0 ];
      window-size = mkTuple [ 933 466 ];
    };

  };
}
