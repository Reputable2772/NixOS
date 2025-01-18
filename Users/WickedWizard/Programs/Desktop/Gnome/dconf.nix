# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/GWeather4" = {
      temperature-unit = "centigrade";
    };

    "org/gnome/TextEditor" = {
      highlight-current-line = false;
      show-line-numbers = true;
    };

    "org/gnome/evince" = {
      document-directory = "file:///home/wickedwizard/Documents/test";
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
      window-ratio = mkTuple [
        0.980392
        0.757576
      ];
      zoom = 0.6921980482933445;
    };

    "org/gnome/evolution" = {
      version = "3.50.4";
    };

    "org/gnome/evolution/calendar" = {
      week-start-day-name = "monday";
      work-day-friday = true;
      work-day-monday = true;
      work-day-saturday = false;
      work-day-sunday = false;
      work-day-thursday = true;
      work-day-tuesday = true;
      work-day-wednesday = true;
    };

    "org/gnome/evolution/mail" = {
      browser-close-on-reply-policy = "ask";
      forward-style-name = "attached";
      image-loading-policy = "never";
      paned-size = 1255591;
      reply-style-name = "quoted";
      to-do-bar-width = 1150000;
    };

    "org/gnome/evolution/shell/window" = {
      maximized = true;
      x = 0;
      y = 0;
    };

    "org/gnome/file-roller/dialogs/add" = {
      current-folder = "file:///home/wickedwizard";
      exclude-files = "";
      exclude-folders = "";
      include-files = "*";
      no-symlinks = true;
      selected-files = [ "file:///home/wickedwizard/Documents" ];
      update = false;
    };

    "org/gnome/file-roller/dialogs/extract" = {
      recreate-folders = true;
      skip-newer = false;
    };

    "org/gnome/file-roller/dialogs/new" = {
      default-extension = ".zip";
      encrypt-header = false;
      expand-options = true;
      volume-size = 0;
    };

    "org/gnome/file-roller/file-selector" = {
      show-hidden = false;
      sidebar-size = 168;
      window-size = mkTuple [
        840
        786
      ];
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

    "org/gnome/pomodoro/plugins/sounds" = {
      pomodoro-end-sound = "bell.ogg";
      pomodoro-end-sound-volume = 1.0;
      pomodoro-start-sound = "loud-bell.ogg";
      pomodoro-start-sound-volume = 1.0;
      ticking-sound = "";
      ticking-sound-volume = 0.2;
    };

    "org/gnome/pomodoro/preferences" = {
      enabled-plugins = [ "sounds" ];
      long-break-duration = 1200.0;
    };

    "org/gnome/pomodoro/state" = {
      timer-date = "2024-03-30T17:46:24+0000";
      timer-elapsed = 0.0;
      timer-paused = false;
      timer-score = 1.3964495619138082;
      timer-state = "null";
      timer-state-date = "2024-03-30T17:46:24+0000";
      timer-state-duration = 0.0;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/gtk4/settings/emoji-chooser" = {
      recent-emoji = [
        (mkTuple [
          (mkTuple [
            [ (mkUint32 128064) ]
            "eyes"
            [
              "eye"
              "face"
            ]
            (mkUint32 1)
          ])
          (mkUint32 0)
        ])
        (mkTuple [
          (mkTuple [
            [ 128517 ]
            "grinning face with sweat"
            [
              "cold"
              "face"
              "open"
              "smile"
              "sweat"
            ]
            0
          ])
          0
        ])
        (mkTuple [
          (mkTuple [
            [ 128514 ]
            "face with tears of joy"
            [
              "face"
              "joy"
              "laugh"
              "tear"
            ]
            0
          ])
          0
        ])
        (mkTuple [
          (mkTuple [
            [
              128077
              0
            ]
            "thumbs up"
            [
              "+1"
              "hand"
              "thumb"
              "up"
            ]
            1
          ])
          0
        ])
      ];
    };

    "org/gtk/settings/color-chooser" = {
      custom-colors = [
        (mkTuple [
          0.9450980392156862
          0.9450980392156862
          0.9450980392156862
          1.0
        ])
        (mkTuple [
          8.627450980392157e-2
          7.84313725490196e-2
          0.10980392156862745
          1.0
        ])
        (mkTuple [
          0.11764705882352941
          0.11764705882352941
          0.1803921568627451
          1.0
        ])
        (mkTuple [
          0.8980392156862745
          0.8980392156862745
          0.8980392156862745
          1.0
        ])
        (mkTuple [
          0.7568627450980392
          0.49019607843137253
          6.666666666666667e-2
          1.0
        ])
      ];
      selected-color = mkTuple [
        true
        0.9450980392156862
        0.9450980392156862
        0.9450980392156862
        1.0
      ];
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
      window-position = mkTuple [
        0
        0
      ];
      window-size = mkTuple [
        1231
        902
      ];
    };

  };
}
