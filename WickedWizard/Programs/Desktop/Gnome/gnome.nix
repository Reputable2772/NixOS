# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "apps/seahorse/listing" = {
      keyrings-selected = [ "secret-service:///org/freedesktop/secrets/collection/login" ];
    };

    "apps/seahorse/windows/key-manager" = {
      height = 1010;
      width = 1920;
    };

    "ca/desrt/dconf-editor" = {
      saved-pathbar-path = "/org/gnome/shell/extensions/bluetooth_battery_indicator/devices";
      saved-view = "/org/gnome/shell/extensions/bluetooth_battery_indicator/devices";
      window-height = 500;
      window-is-maximized = true;
      window-width = 540;
    };

    "com/belmoussaoui/Obfuscate" = {
      is-maximized = true;
    };

    "com/github/GradienceTeam/Gradience" = {
      enabled-plugins = [ "firefox_gnome_theme" ];
      first-run = false;
      last-opened-version = "0.4.1";
      user-flatpak-theming-gtk3 = true;
      user-flatpak-theming-gtk4 = true;
      window-fullscreen = false;
      window-height = 700;
      window-maximized = false;
      window-width = 1000;
    };

    "com/github/wwmm/easyeffects" = {
      last-used-input-preset = "Presets";
      last-used-output-preset = "Presets";
      process-all-outputs = false;
      shutdown-on-window-close = true;
      window-fullscreen = false;
      window-height = 429;
      window-maximized = true;
      window-width = 702;
    };

    "com/github/wwmm/easyeffects/spectrum" = {
      color = mkTuple [ 1.0 1.0 1.0 1.0 ];
      color-axis-labels = mkTuple [ 1.0 1.0 1.0 1.0 ];
    };

    "com/github/wwmm/easyeffects/streaminputs" = {
      input-device = "alsa_input.pci-0000_04_00.6.analog-stereo";
      plugins = [ "rnnoise#0" ];
      use-default-input-device = true;
    };

    "com/github/wwmm/easyeffects/streaminputs/rnnoise/0" = {
      enable-vad = false;
      output-gain = 5.0;
    };

    "com/github/wwmm/easyeffects/streamoutputs" = {
      output-device = "bluez_output.41_42_4C_5C_BB_63.1";
      plugins = [ "bass_enhancer#0" ];
      show-blocklisted-apps = true;
      use-default-output-device = true;
    };

    "com/github/wwmm/easyeffects/streamoutputs/bassenhancer/0" = {
      bypass = false;
      floor-active = true;
      harmonics = 8.5;
    };

    "com/usebottles/bottles" = {
      show-sandbox-warning = false;
      startup-view = "page_list";
      window-height = 1048;
      window-width = 1920;
    };

    "de/haeckerfelix/Fragments" = {
      client-last-connection = "00000000-0000-0000-0000-000000000000";
      window-height = 700;
      window-width = 900;
    };

    "io/github/lainsce/Khronos" = {
      schema-version = 1;
    };

    "net/sapples/LiveCaptions" = {
      active-model = "/nix/store/ikbam9k4kjw51hjbp5asxhivhgr2bc7s-april-english-dev-01110_en.april";
      benchmark = 1.578947;
      fade-text = true;
      filter-profanity = false;
      filter-slurs = false;
      microphone = true;
      text-uppercase = false;
    };

    "org/freedesktop/folks" = {
      primary-store = "eds:05eaed4a46fe4e16938eadee7aa85957e6f379ac";
    };

    "org/freedesktop/tracker/miner/files" = {
      index-single-directories = [ "&DOWNLOAD" ];
    };

    "org/gnome/Connections" = {
      first-run = false;
    };

    "org/gnome/Console" = {
      font-scale = 1.0;
      last-window-size = mkTuple [ 652 481 ];
      theme = "night";
    };

    "org/gnome/Contacts" = {
      did-initial-setup = true;
      sort-on-surname = false;
      window-fullscreen = false;
      window-height = 600;
      window-maximized = true;
      window-width = 800;
    };

    "org/gnome/Disks/benchmark" = {
      do-write = false;
      num-access-samples = 10;
      num-samples = 100;
      sample-size-mib = 10;
    };

    "org/gnome/Fractal" = {
      main-window-state-height = 1010;
      main-window-state-maximized = true;
      main-window-state-width = 1920;
      main-window-state-x = 0;
      main-window-state-y = 0;
    };

    "org/gnome/GWeather4" = {
      temperature-unit = "centigrade";
    };

    "org/gnome/Podcasts" = {
      persist-window-geometry-height = 640;
      persist-window-geometry-maximized = true;
      persist-window-geometry-width = 860;
    };

    "org/gnome/TextEditor" = {
      highlight-current-line = true;
      last-save-directory = "file:///home/wickedwizard/Documents/Study%20Materials/12th/CBSE/Assignments/Physics";
      show-line-numbers = true;
      use-system-font = true;
    };

    "org/gnome/Weather" = {
      locations = "[<(uint32 2, <('Bangalore', 'VOBG', true, [(0.22601989378717041, 1.3555659188172149)], [(0.22631101470640302, 1.3537937114947398)])>)>]";
    };

    "org/gnome/baobab/ui" = {
      is-maximized = false;
      window-size = mkTuple [ 960 600 ];
    };

    "org/gnome/calculator" = {
      accuracy = 9;
      angle-units = "degrees";
      base = 10;
      button-mode = "financial";
      number-format = "automatic";
      show-thousands = false;
      show-zeroes = false;
      source-currency = "EUR";
      source-units = "degree";
      target-currency = "INR";
      target-units = "radian";
      word-size = 64;
    };

    "org/gnome/calendar" = {
      active-view = "month";
      window-maximized = true;
      window-size = mkTuple [ 768 600 ];
    };

    "org/gnome/clocks" = {
      timers = "@aa{sv} []";
    };

    "org/gnome/clocks/state/window" = {
      maximized = false;
      panel-id = "alarm";
      size = mkTuple [ 870 690 ];
    };

    "org/gnome/control-center" = {
      last-panel = "network";
      window-state = mkTuple [ 980 640 true ];
    };

    "org/gnome/desktop/a11y/magnifier" = {
      mag-factor = 13.0;
    };

    "org/gnome/desktop/app-folders" = {
      folder-children = [ "Utilities" "YaST" ];
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [ "gnome-abrt.desktop" "gnome-system-log.desktop" "nm-connection-editor.desktop" "org.gnome.baobab.desktop" "org.gnome.Connections.desktop" "org.gnome.DejaDup.desktop" "org.gnome.Dictionary.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.eog.desktop" "org.gnome.Evince.desktop" "org.gnome.FileRoller.desktop" "org.gnome.fonts.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.tweaks.desktop" "org.gnome.Usage.desktop" "vinagre.desktop" ];
      categories = [ "X-GNOME-Utilities" ];
      name = "X-GNOME-Utilities.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/YaST" = {
      categories = [ "X-SuSE-YaST" ];
      name = "suse-yast.directory";
      translate = true;
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };

    "org/gnome/desktop/input-sources" = {
      show-all-sources = true;
      sources = [ (mkTuple [ "xkb" "us" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      gtk-theme = "Nordic-darker";
      locate-pointer = false;
      show-battery-percentage = true;
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "org-gnome-shell-extensions-gsconnect" "librewolf" "firefox" "beeper" "gnome-power-panel" "obsidian" "com-obsproject-studio" "spotify" "org-flameshot-flameshot" "gnome-network-panel" "schildichat-desktop" "org-gnome-texteditor" "org-gnome-console" "codium" "org-gnome-maps" "org-gnome-evince" "kitty" "org-gnome-eog" "org-gnome-characters" "org-gnome-nautilus" "ca-desrt-dconf-editor" "io-gitlab-news-flash-newsflash" "bitwarden" "-joplinapp-desktop" "de-haeckerfelix-fragments" "mullvadbrowser" "org-gnome-settings" "thunderbird" "org-telegram-desktop" "chromium-browser" "org-gnome-podcasts" "steam" "com-usebottles-bottles" "vlc" "com-github-gradienceteam-gradience" ];
      show-banners = false;
      show-in-lock-screen = true;
    };

    "org/gnome/desktop/notifications/application/-joplinapp-desktop" = {
      application-id = "@joplinapp-desktop.desktop";
    };

    "org/gnome/desktop/notifications/application/beeper" = {
      application-id = "beeper.desktop";
    };

    "org/gnome/desktop/notifications/application/bitwarden" = {
      application-id = "bitwarden.desktop";
    };

    "org/gnome/desktop/notifications/application/ca-desrt-dconf-editor" = {
      application-id = "ca.desrt.dconf-editor.desktop";
    };

    "org/gnome/desktop/notifications/application/chromium-browser" = {
      application-id = "chromium-browser.desktop";
    };

    "org/gnome/desktop/notifications/application/codium" = {
      application-id = "codium.desktop";
    };

    "org/gnome/desktop/notifications/application/com-github-gradienceteam-gradience" = {
      application-id = "com.github.GradienceTeam.Gradience.desktop";
    };

    "org/gnome/desktop/notifications/application/com-obsproject-studio" = {
      application-id = "com.obsproject.Studio.desktop";
    };

    "org/gnome/desktop/notifications/application/com-usebottles-bottles" = {
      application-id = "com.usebottles.bottles.desktop";
    };

    "org/gnome/desktop/notifications/application/de-haeckerfelix-fragments" = {
      application-id = "de.haeckerfelix.Fragments.desktop";
    };

    "org/gnome/desktop/notifications/application/firefox" = {
      application-id = "firefox.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-network-panel" = {
      application-id = "gnome-network-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-power-panel" = {
      application-id = "gnome-power-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/io-gitlab-news-flash-newsflash" = {
      application-id = "io.gitlab.news_flash.NewsFlash.desktop";
    };

    "org/gnome/desktop/notifications/application/kitty" = {
      application-id = "kitty.desktop";
    };

    "org/gnome/desktop/notifications/application/librewolf" = {
      application-id = "librewolf.desktop";
    };

    "org/gnome/desktop/notifications/application/mullvadbrowser" = {
      application-id = "mullvadbrowser.desktop";
    };

    "org/gnome/desktop/notifications/application/obsidian" = {
      application-id = "obsidian.desktop";
    };

    "org/gnome/desktop/notifications/application/org-flameshot-flameshot" = {
      application-id = "org.flameshot.Flameshot.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-characters" = {
      application-id = "org.gnome.Characters.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-console" = {
      application-id = "org.gnome.Console.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-eog" = {
      application-id = "org.gnome.eog.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-evince" = {
      application-id = "org.gnome.Evince.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-maps" = {
      application-id = "org.gnome.Maps.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-nautilus" = {
      application-id = "org.gnome.Nautilus.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-podcasts" = {
      application-id = "org.gnome.Podcasts.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-settings" = {
      application-id = "org.gnome.Settings.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-shell-extensions-gsconnect" = {
      application-id = "org.gnome.Shell.Extensions.GSConnect.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-texteditor" = {
      application-id = "org.gnome.TextEditor.desktop";
    };

    "org/gnome/desktop/notifications/application/org-telegram-desktop" = {
      application-id = "org.telegram.desktop.desktop";
    };

    "org/gnome/desktop/notifications/application/schildichat-desktop" = {
      application-id = "schildichat-desktop.desktop";
    };

    "org/gnome/desktop/notifications/application/spotify" = {
      application-id = "spotify.desktop";
    };

    "org/gnome/desktop/notifications/application/steam" = {
      application-id = "steam.desktop";
    };

    "org/gnome/desktop/notifications/application/thunderbird" = {
      application-id = "thunderbird.desktop";
    };

    "org/gnome/desktop/notifications/application/vlc" = {
      application-id = "vlc.desktop";
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      numlock-state = true;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = 1.0;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      edge-scrolling-enabled = false;
      send-events = "enabled";
      speed = 0.0;
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      disable-camera = true;
      disable-microphone = true;
      old-files-age = mkUint32 30;
      recent-files-max-age = -1;
    };

    "org/gnome/desktop/search-providers" = {
      disabled = [];
      enabled = [ "org.gnome.Weather.desktop" ];
      sort-order = [ "org.gnome.Nautilus.desktop" "org.gnome.Documents.desktop" "org.gnome.Contacts.desktop" "org.gnome.Calculator.desktop" "org.gnome.Calendar.desktop" "org.gnome.Characters.desktop" "org.gnome.clocks.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.Settings.desktop" ];
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 60;
    };

    "org/gnome/desktop/wm/keybindings" = {
      cycle-windows = [];
      cycle-windows-backward = [];
      move-to-workspace-left = [ "<Control><Super>Up" ];
      move-to-workspace-right = [ "<Control><Super>Down" ];
      show-desktop = [ "<Super>d" ];
      switch-applications = [];
      switch-applications-backward = [];
      switch-input-source = [ "<Alt>Shift_L" ];
      switch-to-workspace-left = [ "<Control><Super>Left" ];
      switch-to-workspace-right = [ "<Control><Super>Right" ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
      toggle-fullscreen = [ "F11" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
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
      sizing-mode = "automatic";
      window-ratio = mkTuple [ 1.047386 0.710859 ];
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
    };

    "org/gnome/evolution" = {
      default-address-book = "05eaed4a46fe4e16938eadee7aa85957e6f379ac";
      default-calendar = "3e01427c011feac5c9644676fb52bd9dc1478282";
      version = "3.48.4";
    };

    "org/gnome/evolution/addressbook" = {
      completion-minimum-query-length = 3;
      completion-show-address = false;
      primary-addressbook = "505fbe2df8c7c09af991a0f19bb0d53fa3082691";
    };

    "org/gnome/evolution/calendar" = {
      allow-direct-summary-edit = false;
      confirm-purge = true;
      date-navigator-pane-position = 167;
      editor-show-timezone = false;
      prefer-new-item = "event-new";
      primary-calendar = "47e8f2faf8acad9e89e1996f999bba43f72c1f49";
      primary-memos = "system-memo-list";
      primary-tasks = "system-task-list";
      tag-vpane-position = 1.111e-3;
      time-divisions = 30;
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
      paned-size = 1227027;
      prompt-check-if-default-mailer = false;
      reply-style-name = "quoted";
      to-do-bar-width = 1150000;
    };

    "org/gnome/evolution/shell" = {
      default-component-id = "addressbook";
      folder-bar-width = 259;
    };

    "org/gnome/evolution/shell/window" = {
      height = 480;
      maximized = true;
      width = 640;
      x = 0;
      y = 0;
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
      window-height = 480;
      window-width = 600;
    };

    "org/gnome/maps" = {
      last-viewed-location = [ 12.950596 77.710161 ];
      map-type = "MapsStreetSource";
      transportation-type = "pedestrian";
      window-maximized = true;
      zoom-level = 19;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = true;
    };

    "org/gnome/mutter/wayland/keybindings" = {
      restore-shortcuts = [];
    };

    "org/gnome/nautilus/icon-view" = {
      default-zoom-level = "small";
    };

    "org/gnome/nautilus/list-view" = {
      use-tree-view = true;
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
      search-view = "list-view";
      show-create-link = true;
      show-delete-permanently = false;
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [ 890 550 ];
      maximized = true;
    };

    "org/gnome/nm-applet/eap/0cce0e39-4461-3261-b44a-e55e745bae07" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/0feb9aeb-a39e-49a0-ab66-dd40a7bb0bd5" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = false;
      night-light-last-coordinates = mkTuple [ 12.963584 77.5855 ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      calculator = [ "Calculator" ];
      control-center = [ "<Super>s" ];
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
      mic-mute = [ "F8" ];
      next = [ "AudioNext" ];
      play = [ "AudioPlay" ];
      previous = [ "AudioPrev" ];
      volume-down = [ "AudioLowerVolume" ];
      volume-mute = [ "AudioMute" ];
      volume-up = [ "AudioRaiseVolume" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "Print";
      command = "flameshot gui";
      name = "Screenshot";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-battery-type = "suspend";
    };

    "org/gnome/shell" = {
      app-picker-layout = "[{'waydroid.com.android.inputmethod.latin.desktop': <{'position': <0>}>, 'org.gnome.Contacts.desktop': <{'position': <1>}>, 'org.gnome.Weather.desktop': <{'position': <2>}>, 'org.gnome.clocks.desktop': <{'position': <3>}>, 'org.gnome.Maps.desktop': <{'position': <4>}>, 'beeper.desktop': <{'position': <5>}>, 'bitwarden.desktop': <{'position': <6>}>, 'waydroid.org.lineageos.jelly.desktop': <{'position': <7>}>, 'org.gnome.Calculator.desktop': <{'position': <8>}>, 'waydroid.com.android.calculator2.desktop': <{'position': <9>}>, 'waydroid.org.lineageos.etar.desktop': <{'position': <10>}>, 'org.gnome.Settings.desktop': <{'position': <11>}>, 'gnome-system-monitor.desktop': <{'position': <12>}>, 'calibre-gui.desktop': <{'position': <13>}>, 'waydroid.com.android.camera2.desktop': <{'position': <14>}>, 'waydroid.com.android.deskclock.desktop': <{'position': <15>}>, 'org.gnome.Characters.desktop': <{'position': <16>}>, 'yelp.desktop': <{'position': <17>}>, 'waydroid.com.android.contacts.desktop': <{'position': <18>}>, 'calibre-ebook-edit.desktop': <{'position': <19>}>, 'org.gnome.font-viewer.desktop': <{'position': <20>}>, 'calibre-ebook-viewer.desktop': <{'position': <21>}>, 'com.github.wwmm.easyeffects.desktop': <{'position': <22>}>, 'org.gnome.Extensions.desktop': <{'position': <23>}>}, {'waydroid.com.android.documentsui.desktop': <{'position': <0>}>, 'firefox.desktop': <{'position': <1>}>, 'org.flameshot.Flameshot.desktop': <{'position': <2>}>, 'waydroid.com.android.gallery3d.desktop': <{'position': <3>}>, 'com.github.GradienceTeam.Gradience.desktop': <{'position': <4>}>, 'kitty.desktop': <{'position': <5>}>, 'kvantummanager.desktop': <{'position': <6>}>, 'librewolf.desktop': <{'position': <7>}>, 'calibre-lrfviewer.desktop': <{'position': <8>}>, 'waydroid.org.lineageos.eleven.desktop': <{'position': <9>}>, 'nheko.desktop': <{'position': <10>}>, 'nixos-manual.desktop': <{'position': <11>}>, 'com.obsproject.Studio.desktop': <{'position': <12>}>, 'obsidian.desktop': <{'position': <13>}>, 'qt5ct.desktop': <{'position': <14>}>, 'qt6ct.desktop': <{'position': <15>}>, 'waydroid.org.lineageos.recorder.desktop': <{'position': <16>}>, 'schildichat-desktop.desktop': <{'position': <17>}>, 'waydroid.com.android.settings.desktop': <{'position': <18>}>, 'spotify.desktop': <{'position': <19>}>, 'org.gnome.TextEditor.desktop': <{'position': <20>}>, 'vlc.desktop': <{'position': <21>}>, 'codium.desktop': <{'position': <22>}>, 'Waydroid.desktop': <{'position': <23>}>}, {'org.gnome.FileRoller.desktop': <{'position': <0>}>, 'org.gnome.Connections.desktop': <{'position': <1>}>, 'org.gnome.Console.desktop': <{'position': <2>}>, 'org.gnome.baobab.desktop': <{'position': <3>}>, 'org.gnome.DiskUtility.desktop': <{'position': <4>}>, 'org.gnome.Evince.desktop': <{'position': <5>}>, 'org.gnome.eog.desktop': <{'position': <6>}>, 'org.gnome.Logs.desktop': <{'position': <7>}>, 'org.gnome.seahorse.Application.desktop': <{'position': <8>}>}]";
      command-history = [ "r" "restart" "reload" "lg" ];
      disable-user-extensions = false;
      disabled-extensions = [ "custom-accent-colors@demiskp" ];
      enabled-extensions = [ "appindicatorsupport@rgcjonas.gmail.com" "clipboard-indicator@tudmotu.com" "gsconnect@andyholmes.github.io" "caffeine@patapon.info" "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com" "bluetooth-battery@michalw.github.com" "Vitals@CoreCoding.com" "user-theme@gnome-shell-extensions.gcampax.github.com" ];
      favorite-apps = [ "librewolf.desktop" "firefox.desktop" "@joplinapp-desktop.desktop" "kitty.desktop" "beeper.desktop" "schildichat-desktop.desktop" "spotify.desktop" "codium.desktop" "bitwarden.desktop" ];
      last-selected-power-profile = "power-saver";
      welcome-dialog-last-shown-version = "44.4";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/shell/extensions/appindicator" = {
      icon-opacity = 235;
      legacy-tray-enabled = true;
    };

    "org/gnome/shell/extensions/bluetooth_battery_indicator" = {
      devices = [ ''
        {"name":"Boult Audio Probass","alias":"Boult Audio Probass","isConnected":true,"isPaired":true,"mac":"41:42:4C:5C:BB:63","isDefault":false,"defaultIcon":"audio-headset","percentageSource":"upower","icon":"audio-headphones-symbolic","active":true}
      '' ''
        {"name":"test","alias":"test","isConnected":false,"isPaired":false,"mac":"test","isDefault":false,"defaultIcon":"audio-headset","percentageSource":"upower","active":true,"icon":"audio-headphones-symbolic"}
      '' ];
      hide-indicator = true;
      interval = 1;
    };

    "org/gnome/shell/extensions/caffeine" = {
      indicator-position-max = 2;
      restore-state = false;
      show-indicator = "only-active";
      show-notifications = false;
      toggle-shortcut = [ "<Shift><Control><Alt>c" ];
      toggle-state = false;
    };

    "org/gnome/shell/extensions/clipboard-indicator" = {
      confirm-clear = true;
      next-entry = [ "<Shift><Control><Alt>y" ];
      notify-on-copy = false;
      prev-entry = [ "<Shift><Control><Alt>z" ];
      toggle-menu = [ "<Shift><Control><Alt>a" ];
    };

    "org/gnome/shell/extensions/custom-accent-colors" = {
      accent-color = "green";
      theme-flatpak = false;
      theme-gtk3 = false;
      theme-shell = false;
    };

    "org/gnome/shell/extensions/gsconnect" = {
      devices = [ "d78abea8_98dc_4f3b_9b34_102ef2b16e5d" ];
      enabled = true;
      id = "43515925-5fe7-495b-adb0-7ad321ef7803";
      name = "nixos";
      show-indicators = false;
    };

    "org/gnome/shell/extensions/gsconnect/device/0a585d73_e9e9_4945_be32_27baf898f2ba" = {
      incoming-capabilities = [ "kdeconnect.battery" "kdeconnect.bigscreen.stt" "kdeconnect.clipboard" "kdeconnect.clipboard.connect" "kdeconnect.contacts.request_all_uids_timestamps" "kdeconnect.contacts.request_vcards_by_uid" "kdeconnect.findmyphone.request" "kdeconnect.mousepad.keyboardstate" "kdeconnect.mousepad.request" "kdeconnect.mpris" "kdeconnect.mpris.request" "kdeconnect.notification" "kdeconnect.notification.action" "kdeconnect.notification.reply" "kdeconnect.notification.request" "kdeconnect.ping" "kdeconnect.runcommand" "kdeconnect.sftp.request" "kdeconnect.share.request" "kdeconnect.share.request.update" "kdeconnect.sms.request" "kdeconnect.sms.request_attachment" "kdeconnect.sms.request_conversation" "kdeconnect.sms.request_conversations" "kdeconnect.systemvolume" "kdeconnect.telephony.request" "kdeconnect.telephony.request_mute" ];
      last-connection = "lan://192.168.0.101:1716";
      name = "Galaxy J6+";
      outgoing-capabilities = [ "kdeconnect.battery" "kdeconnect.bigscreen.stt" "kdeconnect.clipboard" "kdeconnect.clipboard.connect" "kdeconnect.connectivity_report" "kdeconnect.contacts.response_uids_timestamps" "kdeconnect.contacts.response_vcards" "kdeconnect.findmyphone.request" "kdeconnect.mousepad.echo" "kdeconnect.mousepad.keyboardstate" "kdeconnect.mousepad.request" "kdeconnect.mpris" "kdeconnect.mpris.request" "kdeconnect.notification" "kdeconnect.notification.request" "kdeconnect.ping" "kdeconnect.presenter" "kdeconnect.runcommand.request" "kdeconnect.sftp" "kdeconnect.share.request" "kdeconnect.sms.attachment_file" "kdeconnect.sms.messages" "kdeconnect.systemvolume.request" "kdeconnect.telephony" ];
      supported-plugins = [ "battery" "clipboard" "connectivity_report" "contacts" "findmyphone" "mousepad" "mpris" "notification" "ping" "presenter" "runcommand" "sftp" "share" "sms" "systemvolume" "telephony" ];
      type = "phone";
    };

    "org/gnome/shell/extensions/gsconnect/device/0a585d73_e9e9_4945_be32_27baf898f2ba/plugin/battery" = {
      custom-battery-notification-value = mkUint32 80;
    };

    "org/gnome/shell/extensions/gsconnect/device/0a585d73_e9e9_4945_be32_27baf898f2ba/plugin/notification" = {
      applications = ''
        {"Printers":{"iconName":"org.gnome.Settings-printers-symbolic","enabled":true},"calibre":{"iconName":"calibre-gui","enabled":true},"Evolution Alarm Notify":{"iconName":"appointment-soon","enabled":true},"Disks":{"iconName":"org.gnome.DiskUtility","enabled":true},"Easy Effects":{"iconName":"com.github.wwmm.easyeffects","enabled":true},"Date & Time":{"iconName":"org.gnome.Settings-time-symbolic","enabled":true},"Disk Usage Analyzer":{"iconName":"org.gnome.baobab","enabled":true},"Power":{"iconName":"org.gnome.Settings-power-symbolic","enabled":true},"Fractal":{"iconName":"org.gnome.Fractal","enabled":true},"Color":{"iconName":"org.gnome.Settings-color-symbolic","enabled":true},"Files":{"iconName":"org.gnome.Nautilus","enabled":true},"Clocks":{"iconName":"org.gnome.clocks","enabled":true},"Archive Manager":{"iconName":"org.gnome.FileRoller","enabled":true},"NewsFlash":{"iconName":"io.gitlab.news_flash.NewsFlash","enabled":true}}
      '';
    };

    "org/gnome/shell/extensions/gsconnect/device/0a585d73_e9e9_4945_be32_27baf898f2ba/plugin/share" = {
      receive-directory = "/home/wickedwizard/Downloads";
    };

    "org/gnome/shell/extensions/gsconnect/device/d78abea8_98dc_4f3b_9b34_102ef2b16e5d" = {
      certificate-pem = "-----BEGIN CERTIFICATE-----MIIDHzCCAgegAwIBAgIBATANBgkqhkiG9w0BAQsFADBTMS0wKwYDVQQDDCRkNzhhYmVhOF85OGRjXzRmM2JfOWIzNF8xMDJlZjJiMTZlNWQxFDASBgNVBAsMC0tERSBDb25uZWN0MQwwCgYDVQQKDANLREUwHhcNMjIwODE1MTgzMDAwWhcNMzIwODE1MTgzMDAwWjBTMS0wKwYDVQQDDCRkNzhhYmVhOF85OGRjXzRmM2JfOWIzNF8xMDJlZjJiMTZlNWQxFDASBgNVBAsMC0tERSBDb25uZWN0MQwwCgYDVQQKDANLREUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCkPj4moAadNTwmMiPy82yssvmIbjc/pnz5tuoLHZfh1vheHvURhEatThiFC8hbwMfB047yXbK6HO41ZavuysDml+okcm3PBvKZjZTyXhCQRPCu6B+VNWn0XwOnmSLlXTkkwVFxN0QAHUi2+mp4+0scHa/Q1Ux7GMQ79LXgxUsewEA42rZk4P9hyHmDwFUr3sVVLh0NwUBC97oIHyHbxdvVZepABT8sqXBvf+HIVGrEsxh+HTpqfNzAT4G+fTesOC0N8eJPdjQmxdHynXSphXipWwI92xSWUJGergjR6zA0v6fq5L4rs0ZwDaSjhqcZu8CWt2S7ACQQK1B38jsgnwPzAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHtRq93nLHQAotvnKwjuuyVzhBAexwwGrkmR1CUJ0ad/9kp9whgzqEJwAtn7Aa2mdjtd+A3omHazEG53AOYnU7hCj3FR7F7suIos2OkJSl6NX5ZBt1l47tWJyVOMEooh5YuSlFUGppyPEQuCksJFM/yaE4cxxeExSVKQ42sVKMt29sad7BwGdv7x/pZ6792ug8AP90VLdQgvhXRbHHHLtU+W0YZoqEWtoEg4bSVT0NY3hgoSXAIxgdiOaWMhrAJCIKrsrrrfQ14xJe0Dvb8tb6/gaM84p3jajNGIeTG9g/PzUzimgdE1rPMOIzycikrKn9ADXBCVDxv/tVqA/9ameAY=-----END CERTIFICATE-----";
      disabled-plugins = [ "photo" ];
      incoming-capabilities = [ "kdeconnect.battery" "kdeconnect.bigscreen.stt" "kdeconnect.clipboard" "kdeconnect.clipboard.connect" "kdeconnect.contacts.request_all_uids_timestamps" "kdeconnect.contacts.request_vcards_by_uid" "kdeconnect.findmyphone.request" "kdeconnect.mousepad.keyboardstate" "kdeconnect.mousepad.request" "kdeconnect.mpris" "kdeconnect.mpris.request" "kdeconnect.notification" "kdeconnect.notification.action" "kdeconnect.notification.reply" "kdeconnect.notification.request" "kdeconnect.ping" "kdeconnect.runcommand" "kdeconnect.sftp.request" "kdeconnect.share.request" "kdeconnect.share.request.update" "kdeconnect.sms.request" "kdeconnect.sms.request_attachment" "kdeconnect.sms.request_conversation" "kdeconnect.sms.request_conversations" "kdeconnect.systemvolume" "kdeconnect.telephony.request" "kdeconnect.telephony.request_mute" ];
      last-connection = "lan://192.168.0.103:1716";
      name = "Redmi  S2";
      outgoing-capabilities = [ "kdeconnect.battery" "kdeconnect.bigscreen.stt" "kdeconnect.clipboard" "kdeconnect.clipboard.connect" "kdeconnect.connectivity_report" "kdeconnect.contacts.response_uids_timestamps" "kdeconnect.contacts.response_vcards" "kdeconnect.findmyphone.request" "kdeconnect.mousepad.echo" "kdeconnect.mousepad.keyboardstate" "kdeconnect.mousepad.request" "kdeconnect.mpris" "kdeconnect.mpris.request" "kdeconnect.notification" "kdeconnect.notification.request" "kdeconnect.ping" "kdeconnect.presenter" "kdeconnect.runcommand.request" "kdeconnect.sftp" "kdeconnect.share.request" "kdeconnect.sms.attachment_file" "kdeconnect.sms.messages" "kdeconnect.systemvolume.request" "kdeconnect.telephony" ];
      paired = true;
      supported-plugins = [ "battery" "clipboard" "connectivity_report" "contacts" "findmyphone" "mousepad" "mpris" "notification" "ping" "presenter" "runcommand" "sftp" "share" "sms" "systemvolume" "telephony" ];
      type = "phone";
    };

    "org/gnome/shell/extensions/gsconnect/device/d78abea8_98dc_4f3b_9b34_102ef2b16e5d/plugin/battery" = {
      custom-battery-notification = true;
      custom-battery-notification-value = mkUint32 80;
      full-battery-notification = true;
      send-statistics = true;
    };

    "org/gnome/shell/extensions/gsconnect/device/d78abea8_98dc_4f3b_9b34_102ef2b16e5d/plugin/clipboard" = {
      receive-content = true;
      send-content = true;
    };

    "org/gnome/shell/extensions/gsconnect/device/d78abea8_98dc_4f3b_9b34_102ef2b16e5d/plugin/notification" = {
      applications = ''
        {"Printers":{"iconName":"org.gnome.Settings-printers-symbolic","enabled":true},"calibre":{"iconName":"calibre-gui","enabled":true},"Evolution Alarm Notify":{"iconName":"appointment-soon","enabled":true},"Telegram Desktop":{"iconName":"telegram","enabled":true},"Disks":{"iconName":"org.gnome.DiskUtility","enabled":true},"Easy Effects":{"iconName":"com.github.wwmm.easyeffects","enabled":true},"Date & Time":{"iconName":"org.gnome.Settings-time-symbolic","enabled":true},"Disk Usage Analyzer":{"iconName":"org.gnome.baobab","enabled":true},"Power":{"iconName":"org.gnome.Settings-power-symbolic","enabled":true},"Fractal":{"iconName":"org.gnome.Fractal","enabled":true},"Color":{"iconName":"org.gnome.Settings-color-symbolic","enabled":true},"Files":{"iconName":"org.gnome.Nautilus","enabled":true},"Clocks":{"iconName":"org.gnome.clocks","enabled":true},"Archive Manager":{"iconName":"org.gnome.FileRoller","enabled":true},"NewsFlash":{"iconName":"io.gitlab.news_flash.NewsFlash","enabled":true},"Spotify":{"iconName":"","enabled":true},"Beeper":{"iconName":"","enabled":true},"Fragments":{"iconName":"folder-download-symbolic","enabled":true},"SchildiChat":{"iconName":"","enabled":true}}
      '';
    };

    "org/gnome/shell/extensions/gsconnect/device/d78abea8_98dc_4f3b_9b34_102ef2b16e5d/plugin/share" = {
      receive-directory = "/home/wickedwizard/Downloads";
    };

    "org/gnome/shell/extensions/gsconnect/device/d78abea8_98dc_4f3b_9b34_102ef2b16e5d/plugin/telephony" = {
      ringing-pause = true;
    };

    "org/gnome/shell/extensions/gsconnect/preferences" = {
      window-maximized = true;
      window-size = mkTuple [ 783 440 ];
    };

    "org/gnome/shell/extensions/rounded-window-corners" = {
      custom-rounded-corner-settings = "@a{sv} {}";
      enable-preferences-entry = true;
      global-rounded-corner-settings = "{'padding': <{'left': <uint32 1>, 'right': <uint32 1>, 'top': <uint32 1>, 'bottom': <uint32 1>}>, 'keep_rounded_corners': <{'maximized': <false>, 'fullscreen': <false>}>, 'border_radius': <uint32 12>, 'smoothing': <uint32 0>}";
      settings-version = mkUint32 5;
      skip-libhandy-app = true;
      tweak-kitty-terminal = true;
    };

    "org/gnome/shell/extensions/system-monitor" = {
      battery-display = false;
      center-display = false;
      compact-display = true;
      cpu-style = "digit";
      fan-show-menu = true;
      freq-style = "digit";
      icon-display = false;
      memory-style = "digit";
      move-clock = false;
      net-display = true;
      net-style = "digit";
      show-on-lockscreen = true;
      show-tooltip = true;
      swap-style = "digit";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "";
    };

    "org/gnome/shell/extensions/vitals" = {
      battery-slot = 1;
      hot-sensors = [ "_processor_usage_" "_memory_usage_" "_temperature_nvme_composite_" "__network-rx_max__" "_temperature_amdgpu_edge_" ];
      include-static-info = false;
      show-battery = true;
    };

    "org/gnome/shell/keybindings" = {
      screenshot = [ "<Alt>Print" ];
      screenshot-window = [ "<Shift>Print" ];
      show-screenshot-ui = [];
      toggle-overview = [];
    };

    "org/gnome/shell/weather" = {
      automatic-location = true;
      locations = "[<(uint32 2, <('Bangalore', 'VOBG', true, [(0.22601989378717041, 1.3555659188172149)], [(0.22631101470640302, 1.3537937114947398)])>)>]";
    };

    "org/gnome/shell/world-clocks" = {
      locations = [];
    };

    "org/gnome/system/location" = {
      enabled = false;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/gtk4/settings/color-chooser" = {
      custom-colors = [ (mkTuple [ 0.5333333611488342 0.7529411911964417 0.8156862854957581 1.0 ]) ];
      selected-color = mkTuple [ true 0.18039216101169586 0.7607843279838562 0.4941176474094391 1.0 ];
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = true;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 140;
      sort-column = "name";
      sort-directories-first = true;
      sort-order = "ascending";
      type-format = "category";
      view-type = "list";
      window-size = mkTuple [ 859 374 ];
    };

    "org/gtk/settings/color-chooser" = {
      selected-color = mkTuple [ true 0.0 ];
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = true;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 188;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [ 30 26 ];
      window-size = mkTuple [ 1203 902 ];
    };

    "org/x/hypnotix" = {
      active-provider = "Index";
      providers = [ "Free-TV:::url:::https://raw.githubusercontent.com/Free-TV/IPTV/master/playlist.m3u8:::::::::" "Index:::url:::https://iptv-org.github.io/iptv/index.nsfw.m3u:::::::::" "India:::url:::https://iptv-org.github.io/iptv/countries/in.m3u:::::::::" ];
    };

  };
}
