{ lib, ... }:
let
  num = [ 1 2 3 4 5 6 7 8 9 ];
  numAttrFunc = x: listToAttrs (map x num);

  inherit (lib.attrsets) listToAttrs nameValuePair;
  inherit (lib.lists) map;
in
{
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "us" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-animations = true;
      show-battery-percentage = true;
      text-scaling-factor = 0.9;
      toolkit-accessibility = false;
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      numlock-state = true;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = 0.365079;
    };

    "org/gnome/desktop/peripherals/pointingstick" = {
      accel-profile = "flat";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      speed = 0.394636;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 120;
    };

    "org/gnome/desktop/wm/keybindings" = {
      move-to-workspace-left = [ "<Control><Super>Left" ];
      move-to-workspace-right = [ "<Control><Super>Right" ];
      switch-applications = [ ];
      switch-applications-backward = [ ];
      switch-to-workspace-left = [ "<Control><Alt>Left" ];
      switch-to-workspace-right = [ "<Control><Alt>Right" ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
      toggle-fullscreen = [ "<Super>f" ];
    } // numAttrFunc (x: nameValuePair "move-to-workspace-${toString x}" [ "<Control><Super>${toString x}" ])
    // numAttrFunc (x: nameValuePair "switch-to-workspace-${toString x}" [ "<Super>${toString x}" ]);

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      num-workspaces = 9;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = true;
      workspaces-only-on-primary = false;
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      search-filter-time-type = "last_modified";
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      home = [ "<Super>e" ];
      next = [ "AudioNext" ];
      play = [ "AudioPlay" ];
      previous = [ "AudioPrev" ];
      volume-down = [ "AudioLowerVolume" ];
      volume-mute = [ "AudioMute" ];
      volume-up = [ "AudioRaiseVolume" ];
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/shell/keybindings" =
      numAttrFunc (x: nameValuePair "open-new-window-application-${toString x}" [ "<Control><Alt>${toString x}" ])
      // numAttrFunc (x: nameValuePair "switch-to-application-${toString x}" [ ]);

    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = true;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 183;
      sort-column = "type";
      sort-directories-first = true;
      sort-order = "descending";
      type-format = "category";
      window-position = mkTuple [ 103 103 ];
      window-size = mkTuple [ 1008 735 ];
    };
  };
}
