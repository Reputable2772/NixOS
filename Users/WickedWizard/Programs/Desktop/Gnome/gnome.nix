# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "apps/seahorse" = {
      server-auto-publish = false;
      server-auto-retrieve = false;
      server-publish-to = "";
    };

    "apps/seahorse/listing" = {
      item-filter = "any";
      keyrings-selected = [ "openssh:///home/wickedwizard/.ssh" ];
    };

    "apps/seahorse/windows/key-manager" = {
      height = 1001;
      width = 1920;
    };

    "ca/desrt/dconf-editor" = {
      saved-pathbar-path = "/org/gnome/shell/extensions/gsconnect/device/d78abea8_98dc_4f3b_9b34_102ef2b16e5d/keybindings";
      saved-view = "/org/gnome/shell/extensions/gsconnect/device/d78abea8_98dc_4f3b_9b34_102ef2b16e5d/keybindings";
      window-height = 500;
      window-is-maximized = true;
      window-width = 540;
    };

    "com/belmoussaoui/Authenticator" = {
      is-maximized = true;
      keyrings-migrated = true;
      window-height = 600;
      window-width = 720;
    };

    "com/github/GradienceTeam/Gradience" = {
      enabled-plugins = [ ];
      first-run = false;
      last-opened-version = "0.4.1";
      window-fullscreen = false;
      window-height = 700;
      window-maximized = true;
      window-width = 1000;
    };

    "com/github/marhkb/Pods" = {
      color-scheme = "dark";
      is-maximized = true;
      last-used-connection = "9a12e140-1f81-48ca-9568-74d3a4448ea6";
      last-used-view = "containers";
      prune-all-images = true;
      prune-external-images = true;
      show-intermediate-images = false;
      show-log-timestamps = false;
      show-only-running-containers = false;
      text-view-font-scale = 1.0;
      window-height = 400;
      window-width = 600;
    };

    "com/github/wwmm/easyeffects" = {
      last-used-input-preset = "Presets";
      last-used-output-preset = "Presets";
      process-all-inputs = true;
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

    "com/github/wwmm/easyeffects/streamoutputs/stereotools/0" = {
      softclip = true;
    };

    "com/usebottles/bottles" = {
      window-height = 1048;
      window-width = 1920;
    };

    "fr/romainvigier/MetadataCleaner" = {
      cleaning-without-warning = false;
      window-height = mkUint32 600;
      window-maximized = true;
      window-width = mkUint32 400;
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
      index-recursive-directories = [ "&DESKTOP" "&DOCUMENTS" ];
      index-single-directories = [ "&DOWNLOAD" ];
    };

    "org/gnome/Connections" = {
      first-run = false;
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

    "org/gnome/Fractal/Stable" = {
      current-session = "7ecb27dd-f8c4-400c-8956-2d488cac633d";
      is-maximized = true;
      markdown-enabled = true;
      sessions = "[[\"7ecb27dd-f8c4-400c-8956-2d488cac633d\",{}]]";
      window-height = 589;
      window-width = 637;
    };

    "org/gnome/GWeather4" = {
      temperature-unit = "centigrade";
    };

    "org/gnome/Snapshot" = {
      is-maximized = true;
      show-composition-guidelines = false;
      window-height = 640;
      window-width = 800;
    };

    "org/gnome/TextEditor" = {
      auto-indent = true;
      highlight-current-line = true;
      last-save-directory = "file:///home/wickedwizard/Documents/Study%20Materials/12th/CBSE/Assignments/Physics";
      show-line-numbers = true;
      style-variant = "dark";
      use-system-font = true;
    };

    "org/gnome/Weather" = {
      locations = "[<(uint32 2, <('Bangalore', 'VOBG', true, [(0.22601989378717041, 1.3555659188172149)], [(0.22631101470640302, 1.3537937114947398)])>)>]";
      window-height = 416;
      window-maximized = true;
      window-width = 992;
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
      source-currency = "DZD";
      source-units = "degree";
      target-currency = "DZD";
      target-units = "radian";
      window-maximized = true;
      window-size = mkTuple [ 680 584 ];
      word-size = 64;
    };

    "org/gnome/calendar" = {
      active-view = "month";
      window-maximized = true;
      window-size = mkTuple [ 768 600 ];
    };

    "org/gnome/clocks/state/window" = {
      maximized = false;
      panel-id = "world";
      size = mkTuple [ 870 690 ];
    };

    "org/gnome/control-center" = {
      last-panel = "power";
      window-state = mkTuple [ 980 640 false ];
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

    "org/gnome/desktop/background" = {
      picture-options = "zoom";
      picture-uri = "file:///home/wickedwizard/.config/background";
      picture-uri-dark = "file:///home/wickedwizard/.config/background";
      primary-color = "#3a4ba0";
      secondary-color = "#2f302f";
      show-desktop-icons = true;
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };

    "org/gnome/desktop/input-sources" = {
      show-all-sources = true;
      sources = [ (mkTuple [ "xkb" "us" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" "mod_led:compose" ];
    };

    "org/gnome/desktop/interface" = {
      clock-show-seconds = true;
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      cursor-theme = "Nordic-cursors";
      enable-animations = true;
      font-antialiasing = "rgba";
      font-hinting = "full";
      gtk-theme = "adw-gtk3-dark";
      icon-theme = "Adwaita";
      locate-pointer = false;
      show-battery-percentage = true;
      text-scaling-factor = 1.0;
      toolkit-accessibility = false;
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "io-gitlab-news-flash-newsflash" "org-flameshot-flameshot" "beeper" "gnome-power-panel" "org-gnome-shell-extensions-gsconnect" "librewolf" "org-gnome-evolution-alarm-notify" "com-obsproject-studio" "org-gnome-evince" "codium" "electron-mail" "-joplinapp-desktop" "firefox" "spotify" "org-gnome-fractal" "bitwarden" "org-gnome-nautilus" "com-github-gradienceteam-gradience" "gnome-network-panel" "org-telegram-desktop" "discord" ];
      show-banners = false;
      show-in-lock-screen = false;
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

    "org/gnome/desktop/notifications/application/chromium-browser" = {
      application-id = "chromium-browser.desktop";
    };

    "org/gnome/desktop/notifications/application/codium" = {
      application-id = "codium.desktop";
    };

    "org/gnome/desktop/notifications/application/com-github-gradienceteam-gradience" = {
      application-id = "com.github.GradienceTeam.Gradience.desktop";
    };

    "org/gnome/desktop/notifications/application/com-github-marhkb-pods" = {
      application-id = "com.github.marhkb.Pods.desktop";
    };

    "org/gnome/desktop/notifications/application/com-github-wwmm-easyeffects" = {
      application-id = "com.github.wwmm.easyeffects.desktop";
    };

    "org/gnome/desktop/notifications/application/com-obsproject-studio" = {
      application-id = "com.obsproject.Studio.desktop";
    };

    "org/gnome/desktop/notifications/application/com-ranfdev-notify" = {
      application-id = "com.ranfdev.Notify.desktop";
    };

    "org/gnome/desktop/notifications/application/deluge" = {
      application-id = "deluge.desktop";
    };

    "org/gnome/desktop/notifications/application/discord" = {
      application-id = "discord.desktop";
    };

    "org/gnome/desktop/notifications/application/electron-mail" = {
      application-id = "electron-mail.desktop";
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

    "org/gnome/desktop/notifications/application/impress" = {
      application-id = "impress.desktop";
    };

    "org/gnome/desktop/notifications/application/io-freetubeapp-freetube" = {
      application-id = "io.freetubeapp.FreeTube.desktop";
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

    "org/gnome/desktop/notifications/application/org-flameshot-flameshot" = {
      application-id = "org.flameshot.Flameshot.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-evince" = {
      application-id = "org.gnome.Evince.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-evolution-alarm-notify" = {
      application-id = "org.gnome.Evolution-alarm-notify.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-fileroller" = {
      application-id = "org.gnome.FileRoller.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-fractal" = {
      application-id = "org.gnome.Fractal.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-nautilus" = {
      application-id = "org.gnome.Nautilus.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-shell-extensions-gsconnect" = {
      application-id = "org.gnome.Shell.Extensions.GSConnect.desktop";
    };

    "org/gnome/desktop/notifications/application/org-qbittorrent-qbittorrent" = {
      application-id = "org.qbittorrent.qBittorrent.desktop";
    };

    "org/gnome/desktop/notifications/application/org-telegram-desktop" = {
      application-id = "org.telegram.desktop.desktop";
    };

    "org/gnome/desktop/notifications/application/spotify" = {
      application-id = "spotify.desktop";
    };

    "org/gnome/desktop/notifications/application/steam" = {
      application-id = "steam.desktop";
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

    "org/gnome/desktop/remote-desktop/rdp" = {
      enable = true;
      tls-cert = "/home/wickedwizard/.local/share/gnome-remote-desktop/rdp-tls.crt";
      tls-key = "/home/wickedwizard/.local/share/gnome-remote-desktop/rdp-tls.key";
      view-only = false;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///nix/store/xax2fz0mcj3vg0nzw5l523gf6rlzcii8-simple-blue-2016-02-19/share/backgrounds/nixos/nix-wallpaper-simple-blue.png";
      primary-color = "#3a4ba0";
      secondary-color = "#2f302f";
    };

    "org/gnome/desktop/search-providers" = {
      disabled = [ ];
      enabled = [ "org.gnome.Weather.desktop" ];
      sort-order = [ "org.gnome.Nautilus.desktop" "org.gnome.Documents.desktop" "org.gnome.Contacts.desktop" "org.gnome.Calculator.desktop" "org.gnome.Calendar.desktop" "org.gnome.Characters.desktop" "org.gnome.clocks.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.Settings.desktop" ];
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 300;
    };

    "org/gnome/desktop/wm/keybindings" = {
      cycle-windows = [ ];
      cycle-windows-backward = [ ];
      move-to-workspace-left = [ "<Control><Super>Up" ];
      move-to-workspace-right = [ "<Control><Super>Down" ];
      show-desktop = [ "<Super>d" ];
      switch-applications = [ ];
      switch-applications-backward = [ ];
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
      dual-page-odd-left = true;
      enable-spellchecking = true;
      fullscreen = false;
      inverted-colors = false;
      show-sidebar = false;
      sidebar-page = "thumbnails";
      sidebar-size = 132;
      sizing-mode = "fit-width";
      window-ratio = mkTuple [ 1.6134453781512605 1.2446555819477434 ];
      zoom = 1.07268;
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
    };

    "org/gnome/evolution-data-server/calendar" = {
      reminders-past = [ "4e68caa2d3b1640cdfdcf5cdd894444912b501bb4c02bd1ca962da8df9f62c7ba87ad5a31366a196t20240107T203000170463960117046396001704639601BEGIN:VTODOrDTSTAMP:20231215T150356ZrUID:1294331700948191936rSEQUENCE:17rCREATED:20231025T155852ZrLAST-MODIFIED:20231217T035729ZrSUMMARY:Take Tab from SmallyrPRIORITY:1rSTATUS:COMPLETEDrRRULE:FREQ=DAILYrX-APPLE-SORT-ORDER:719765958rDUE;TZID=Asia/Kolkata:20231216T203001rDTSTART;TZID=Asia/Kolkata:20240107T203000rPERCENT-COMPLETE:100rCOMPLETED:20231217T000000ZrX-EVOLUTION-CALDAV-ETAG:54e34cb0cf96e7a9b29b57f7d2ce8ae5rRECURRENCE-ID;TZID=Asia/Kolkata:20240107T203000rDTEND;TZID=Asia/Kolkata:20240107T203001rBEGIN:VALARMrTRIGGER;RELATED=START:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:68b55f8ee84060a2cab6f43defae203deabbb3bcrEND:VALARMrBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:4c02bd1ca962da8df9f62c7ba87ad5a31366a196rEND:VALARMrEND:VTODOr" "16669dd59a5baadbcec39840a104bcdf72a3b89d4c02bd1ca962da8df9f62c7ba87ad5a31366a196t20240107T203000170463960117046396001704639601BEGIN:VTODOrDTSTAMP:20231215T150356ZrUID:1294331700948191936rSEQUENCE:17rCREATED:20231025T155852ZrLAST-MODIFIED:20231217T035729ZrSUMMARY:Take Tab from SmallyrPRIORITY:1rSTATUS:COMPLETEDrRRULE:FREQ=DAILYrX-APPLE-SORT-ORDER:719765958rDUE;TZID=Asia/Kolkata:20231216T203001rDTSTART;TZID=Asia/Kolkata:20240107T203000rPERCENT-COMPLETE:100rCOMPLETED:20231217T000000ZrX-EVOLUTION-CALDAV-ETAG:54e34cb0cf96e7a9b29b57f7d2ce8ae5rRECURRENCE-ID;TZID=Asia/Kolkata:20240107T203000rDTEND;TZID=Asia/Kolkata:20240107T203001rBEGIN:VALARMrTRIGGER;RELATED=START:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:68b55f8ee84060a2cab6f43defae203deabbb3bcrEND:VALARMrBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:4c02bd1ca962da8df9f62c7ba87ad5a31366a196rEND:VALARMrEND:VTODOr" "4e68caa2d3b1640cdfdcf5cdd894444912b501bb68b55f8ee84060a2cab6f43defae203deabbb3bct20240107T203000170463960017046396001704639601BEGIN:VTODOrDTSTAMP:20231215T150356ZrUID:1294331700948191936rSEQUENCE:17rCREATED:20231025T155852ZrLAST-MODIFIED:20231217T035729ZrSUMMARY:Take Tab from SmallyrPRIORITY:1rSTATUS:COMPLETEDrRRULE:FREQ=DAILYrX-APPLE-SORT-ORDER:719765958rDUE;TZID=Asia/Kolkata:20231216T203001rDTSTART;TZID=Asia/Kolkata:20240107T203000rPERCENT-COMPLETE:100rCOMPLETED:20231217T000000ZrX-EVOLUTION-CALDAV-ETAG:54e34cb0cf96e7a9b29b57f7d2ce8ae5rRECURRENCE-ID;TZID=Asia/Kolkata:20240107T203000rDTEND;TZID=Asia/Kolkata:20240107T203001rBEGIN:VALARMrTRIGGER;RELATED=START:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:68b55f8ee84060a2cab6f43defae203deabbb3bcrEND:VALARMrBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:4c02bd1ca962da8df9f62c7ba87ad5a31366a196rEND:VALARMrEND:VTODOr" "16669dd59a5baadbcec39840a104bcdf72a3b89d68b55f8ee84060a2cab6f43defae203deabbb3bct20240107T203000170463960017046396001704639601BEGIN:VTODOrDTSTAMP:20231215T150356ZrUID:1294331700948191936rSEQUENCE:17rCREATED:20231025T155852ZrLAST-MODIFIED:20231217T035729ZrSUMMARY:Take Tab from SmallyrPRIORITY:1rSTATUS:COMPLETEDrRRULE:FREQ=DAILYrX-APPLE-SORT-ORDER:719765958rDUE;TZID=Asia/Kolkata:20231216T203001rDTSTART;TZID=Asia/Kolkata:20240107T203000rPERCENT-COMPLETE:100rCOMPLETED:20231217T000000ZrX-EVOLUTION-CALDAV-ETAG:54e34cb0cf96e7a9b29b57f7d2ce8ae5rRECURRENCE-ID;TZID=Asia/Kolkata:20240107T203000rDTEND;TZID=Asia/Kolkata:20240107T203001rBEGIN:VALARMrTRIGGER;RELATED=START:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:68b55f8ee84060a2cab6f43defae203deabbb3bcrEND:VALARMrBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:4c02bd1ca962da8df9f62c7ba87ad5a31366a196rEND:VALARMrEND:VTODOr" ];
    };

    "org/gnome/evolution" = {
      default-address-book = "05eaed4a46fe4e16938eadee7aa85957e6f379ac";
      default-calendar = "53bdb9fd191cf5643cccf8b4f867cdb3e4ba490b";
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

    "org/gnome/gnome-system-monitor" = {
      current-tab = "resources";
      maximized = true;
      network-total-in-bits = false;
      show-dependencies = false;
      show-whose-processes = "user";
      window-state = mkTuple [ 1920 1048 0 0 ];
    };

    "org/gnome/gnome-system-monitor/disktreenew" = {
      col-6-visible = true;
      col-6-width = 0;
    };

    "org/gnome/maps" = {
      last-viewed-location = [ 12.950596 77.710161 ];
      map-type = "MapsStreetSource";
      show-scale = false;
      transportation-type = "pedestrian";
      window-maximized = true;
      zoom-level = 19;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = true;
    };

    "org/gnome/mutter/wayland/keybindings" = {
      restore-shortcuts = [ ];
    };

    "org/gnome/nautilus/compression" = {
      default-compression-format = "7z";
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

    "org/gnome/portal/filechooser/beeper" = {
      last-folder-path = "/home/wickedwizard/Documents/Study Materials/12th/CBSE/Assignments/Computer";
    };

    "org/gnome/portal/filechooser/chromium-browser" = {
      last-folder-path = "/home/wickedwizard/Downloads";
    };

    "org/gnome/portal/filechooser/com/github/GradienceTeam/Gradience/Devel" = {
      last-folder-path = "/home/wickedwizard/.config";
    };

    "org/gnome/portal/filechooser/kitty" = {
      last-folder-path = "/home/wickedwizard/Mounted/Important-Files/Exams";
    };

    "org/gnome/portal/filechooser/org/gnome/Fractal" = {
      last-folder-path = "/home/wickedwizard/Documents";
    };

    "org/gnome/portal/filechooser/org/gnome/Settings" = {
      last-folder-path = "/home/wickedwizard/Documents/Applications/Containers/ProtonVPN";
    };

    "org/gnome/power-manager" = {
      info-history-graph-points = false;
      info-history-graph-smooth = false;
      info-history-time = 10800;
      info-history-type = "time-empty";
      info-last-device = "/org/freedesktop/UPower/devices/battery_BAT1";
      info-page-number = 0;
      info-stats-type = "discharge-accuracy";
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
      command = "/home/wickedwizard/Documents/NixOS/flameshot.sh";
      name = "Screenshot";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      idle-dim = true;
      sleep-inactive-battery-type = "suspend";
    };

    "org/gnome/shell" = {
      app-picker-layout = "[{'org.gnome.Contacts.desktop': <{'position': <0>}>, 'org.gnome.Weather.desktop': <{'position': <1>}>, 'org.gnome.clocks.desktop': <{'position': <2>}>, 'waydroid.com.android.inputmethod.latin.desktop': <{'position': <3>}>, 'org.gnome.Maps.desktop': <{'position': <4>}>, 'waydroid.de.danoeh.antennapod.desktop': <{'position': <5>}>, 'com.belmoussaoui.Authenticator.desktop': <{'position': <6>}>, 'com.usebottles.bottles.desktop': <{'position': <7>}>, 'org.gnome.Calculator.desktop': <{'position': <8>}>, 'waydroid.org.lineageos.jelly.desktop': <{'position': <9>}>, 'org.gnome.Settings.desktop': <{'position': <10>}>, 'waydroid.com.android.calculator2.desktop': <{'position': <11>}>, 'gnome-system-monitor.desktop': <{'position': <12>}>, 'org.gnome.Calendar.desktop': <{'position': <13>}>, 'org.gnome.Terminal.desktop': <{'position': <14>}>, 'Utilities': <{'position': <15>}>, 'waydroid.org.lineageos.etar.desktop': <{'position': <16>}>, 'yelp.desktop': <{'position': <17>}>, 'calibre-gui.desktop': <{'position': <18>}>, 'org.gnome.Snapshot.desktop': <{'position': <19>}>, 'waydroid.com.android.camera2.desktop': <{'position': <20>}>, 'chromium-browser.desktop': <{'position': <21>}>, 'waydroid.com.android.deskclock.desktop': <{'position': <22>}>, 'Computer_Class.desktop': <{'position': <23>}>}, {'conky.desktop': <{'position': <0>}>, 'waydroid.com.android.contacts.desktop': <{'position': <1>}>, 'ca.desrt.dconf-editor.desktop': <{'position': <2>}>, 'deluge.desktop': <{'position': <3>}>, 'discord.desktop': <{'position': <4>}>, 'calibre-ebook-edit.desktop': <{'position': <5>}>, 'calibre-ebook-viewer.desktop': <{'position': <6>}>, 'com.github.wwmm.easyeffects.desktop': <{'position': <7>}>, 'io.github.mrvladus.List.desktop': <{'position': <8>}>, 'org.gnome.Extensions.desktop': <{'position': <9>}>, 'feishin.desktop': <{'position': <10>}>, 'Filen.desktop': <{'position': <11>}>, 'waydroid.com.android.documentsui.desktop': <{'position': <12>}>, 'org.gnome.Nautilus.desktop': <{'position': <13>}>, 'org.flameshot.Flameshot.desktop': <{'position': <14>}>, 'org.gnome.Fractal.desktop': <{'position': <15>}>, 'io.freetubeapp.FreeTube.desktop': <{'position': <16>}>, 'waydroid.com.android.gallery3d.desktop': <{'position': <17>}>, 'io.github.realmazharhussain.GdmSettings.desktop': <{'position': <18>}>, 'waydroid.com.android.vending.desktop': <{'position': <19>}>, 'com.github.GradienceTeam.Gradience.desktop': <{'position': <20>}>, 'com.github.GradienceTeam.Gradience.Devel.desktop': <{'position': <21>}>, 'waydroid.in.startv.hotstar.desktop': <{'position': <22>}>, 'org.gnome.Loupe.desktop': <{'position': <23>}>}, {'waydroid.com.jio.media.ondemand.desktop': <{'position': <0>}>, 'kodi.desktop': <{'position': <1>}>, 'kvantummanager.desktop': <{'position': <2>}>, 'startcenter.desktop': <{'position': <3>}>, 'base.desktop': <{'position': <4>}>, 'calc.desktop': <{'position': <5>}>, 'draw.desktop': <{'position': <6>}>, 'impress.desktop': <{'position': <7>}>, 'math.desktop': <{'position': <8>}>, 'writer.desktop': <{'position': <9>}>, 'net.sapples.LiveCaptions.desktop': <{'position': <10>}>, 'calibre-lrfviewer.desktop': <{'position': <11>}>, 'waydroid.me.zhanghai.android.files.desktop': <{'position': <12>}>, 'chrome-cifhbcnohmdccbgoicgdjpfamggdegmo-Default.desktop': <{'position': <13>}>, 'mpv.desktop': <{'position': <14>}>, 'mullvadbrowser.desktop': <{'position': <15>}>, 'waydroid.org.lineageos.eleven.desktop': <{'position': <16>}>, 'org.musicbrainz.Picard.desktop': <{'position': <17>}>, 'io.gitlab.news_flash.NewsFlash.desktop': <{'position': <18>}>, 'nixos-manual.desktop': <{'position': <19>}>, 'com.ranfdev.Notify.desktop': <{'position': <20>}>, 'com.obsproject.Studio.desktop': <{'position': <21>}>, 'io.github.kaii_lb.Overskride.desktop': <{'position': <22>}>, 'com.github.alainm23.planner.desktop': <{'position': <23>}>}, {'com.github.marhkb.Pods.desktop': <{'position': <0>}>, 'org.gnome.PowerStats.desktop': <{'position': <1>}>, 'org.prismlauncher.PrismLauncher.desktop': <{'position': <2>}>, 'Proton Experimental.desktop': <{'position': <3>}>, 'protonvpn-app.desktop': <{'position': <4>}>, 'org.qbittorrent.qBittorrent.desktop': <{'position': <5>}>, 'qt5ct.desktop': <{'position': <6>}>, 'qt6ct.desktop': <{'position': <7>}>, 'waydroid.org.lineageos.recorder.desktop': <{'position': <8>}>, 'waydroid.com.android.settings.desktop': <{'position': <9>}>, 'signal-desktop.desktop': <{'position': <10>}>, 'waydroid.cu.axel.smartdock.desktop': <{'position': <11>}>, 'steam.desktop': <{'position': <12>}>, 'Steam Linux Runtime 3.0 (sniper).desktop': <{'position': <13>}>, 'me.kozec.syncthingtk.desktop': <{'position': <14>}>, 'org.telegram.desktop.desktop': <{'position': <15>}>, 'org.gnome.TextEditor.desktop': <{'position': <16>}>, 'torbrowser.desktop': <{'position': <17>}>, 'TrackMania Nations Forever.desktop': <{'position': <18>}>, 'vlc.desktop': <{'position': <19>}>, 'com.colorata.wallman.desktop': <{'position': <20>}>, 'Waydroid.desktop': <{'position': <21>}>, 'org.gnome.Epiphany.desktop': <{'position': <22>}>, 'com.github.eneshecan.WhatsAppForLinux.desktop': <{'position': <23>}>}, {'chrome-agimnkijcaahngcdmfeangaknmldooml-Profile_5.desktop': <{'position': <0>}>}]";
      command-history = [ "r" "restart" "reload" "lg" ];
      disable-user-extensions = false;
      disabled-extensions = [ "custom-accent-colors@demiskp" "light-style@gnome-shell-extensions.gcampax.github.com" ];
      enabled-extensions = [ "appindicatorsupport@rgcjonas.gmail.com" "clipboard-indicator@tudmotu.com" "caffeine@patapon.info" "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com" "bluetooth-battery@michalw.github.com" "Vitals@CoreCoding.com" "user-theme@gnome-shell-extensions.gcampax.github.com" "gsconnect@andyholmes.github.io" "just-perfection-desktop@just-perfection" "launch-new-instance@gnome-shell-extensions.gcampax.github.com" "rounded-window-corners@yilozt" "pano@elhan.io" ];
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

    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [ "spotify.desktop:2" "kitty.desktop:2" "@joplinapp-desktop.desktop:1" "io.github.lainsce.Khronos.desktop:1" ];
    };

    "org/gnome/shell/extensions/bluetooth_battery_indicator" = {
      devices = [
        ''
          {"name":"Redmi S2","alias":"Redmi S2","isConnected":false,"isPaired":true,"mac":"08:25:25:A0:40:49","isDefault":false,"defaultIcon":"phone"}
        ''
        ''
          {"name":"Boult Audio Probass","alias":"Boult Audio Probass","isConnected":true,"isPaired":true,"mac":"41:42:4C:5C:BB:63","isDefault":false,"defaultIcon":"audio-headset","percentageSource":"upower","icon":"audio-headphones-symbolic","active":true}
        ''
      ];
      hide-indicator = true;
      interval = 1;
    };

    "org/gnome/shell/extensions/caffeine" = {
      indicator-position-max = 3;
      restore-state = false;
      show-indicator = "only-active";
      show-notifications = false;
      toggle-shortcut = [ "<Shift><Control><Alt>c" ];
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
      name = "Redmi S2";
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
        {"Printers":{"iconName":"org.gnome.Settings-printers-symbolic","enabled":true},"calibre":{"iconName":"calibre-gui","enabled":true},"Evolution Alarm Notify":{"iconName":"appointment-soon","enabled":true},"Telegram Desktop":{"iconName":"telegram","enabled":true},"Disks":{"iconName":"org.gnome.DiskUtility","enabled":true},"Easy Effects":{"iconName":"com.github.wwmm.easyeffects","enabled":true},"Date & Time":{"iconName":"org.gnome.Settings-time-symbolic","enabled":true},"Disk Usage Analyzer":{"iconName":"org.gnome.baobab","enabled":true},"Power":{"iconName":"org.gnome.Settings-power-symbolic","enabled":true},"Fractal":{"iconName":"org.gnome.Fractal","enabled":true},"Color":{"iconName":"org.gnome.Settings-color-symbolic","enabled":true},"Files":{"iconName":"org.gnome.Nautilus","enabled":true},"Clocks":{"iconName":"org.gnome.clocks","enabled":true},"Archive Manager":{"iconName":"org.gnome.FileRoller","enabled":true},"NewsFlash":{"iconName":"io.gitlab.news_flash.NewsFlash","enabled":true},"Spotify":{"iconName":"","enabled":true},"Beeper":{"iconName":"","enabled":true},"Fragments":{"iconName":"folder-download-symbolic","enabled":true},"SchildiChat":{"iconName":"","enabled":true},"Deluge":{"iconName":"deluge","enabled":true},"Software":{"iconName":"org.gnome.Software","enabled":true},"flameshot":{"iconName":"","enabled":true},"Flameshot":{"iconName":"flameshot","enabled":true},"Firefox":{"iconName":"","enabled":true},"Planner":{"iconName":"com.github.alainm23.planner","enabled":true},"Notify":{"iconName":"com.ranfdev.Notify","enabled":true}}
      '';
    };

    "org/gnome/shell/extensions/gsconnect/device/d78abea8_98dc_4f3b_9b34_102ef2b16e5d/plugin/runcommand" = {
      command-list = "{'lock': <{'name': 'Lock', 'command': 'xdg-screensaver lock'}>, 'restart': <{'name': 'Restart', 'command': 'systemctl reboot'}>, 'logout': <{'name': 'Log Out', 'command': 'gnome-session-quit --logout --no-prompt'}>, 'poweroff': <{'name': 'Power Off', 'command': 'systemctl poweroff'}>, 'suspend': <{'name': 'Suspend', 'command': 'systemctl suspend'}>, 'bb91edd0-d649-42ed-b7fd-70866071b7b8': <{'name': 'Unlock', 'command': 'SESSION=$(loginctl list-sessions | grep $(whoami) | awk '{print $1}'); loginctl unlock-session $SESSION'}>}";
    };

    "org/gnome/shell/extensions/gsconnect/device/d78abea8_98dc_4f3b_9b34_102ef2b16e5d/plugin/share" = {
      receive-directory = "/home/wickedwizard/Downloads";
    };

    "org/gnome/shell/extensions/gsconnect/device/d78abea8_98dc_4f3b_9b34_102ef2b16e5d/plugin/telephony" = {
      ringing-pause = true;
    };

    "org/gnome/shell/extensions/gsconnect/messaging" = {
      window-maximized = true;
    };

    "org/gnome/shell/extensions/gsconnect/preferences" = {
      window-maximized = true;
      window-size = mkTuple [ 783 440 ];
    };

    "org/gnome/shell/extensions/just-perfection" = {
      accessibility-menu = true;
      activities-button = true;
      animation = 1;
      app-menu = false;
      app-menu-icon = true;
      app-menu-label = false;
      background-menu = true;
      clock-menu = true;
      clock-menu-position = 2;
      clock-menu-position-offset = 1;
      controls-manager-spacing-size = 0;
      dash = true;
      dash-app-running = true;
      dash-icon-size = 0;
      double-super-to-appgrid = true;
      keyboard-layout = true;
      notification-banner-position = 0;
      osd = true;
      overlay-key = true;
      panel = true;
      panel-icon-size = 0;
      panel-in-overview = true;
      panel-size = 0;
      quick-settings = true;
      ripple-box = true;
      search = true;
      show-apps-button = true;
      startup-status = 1;
      theme = false;
      window-demands-attention-focus = false;
      window-picker-icon = true;
      window-preview-caption = true;
      window-preview-close-button = true;
      workspace = true;
      workspace-background-corner-size = 0;
      workspace-peek = true;
      workspace-popup = true;
      workspace-switcher-should-show = false;
      workspace-wrap-around = true;
      workspaces-in-app-grid = true;
    };

    "org/gnome/shell/extensions/pano" = {
      exclusion-list = [ "Bitwarden" "1Password" "KeePassXC" "secrets" "org.gnome.World.Secrets" "org.keepassxc.KeePassXC" "kitty" ];
      global-shortcut = [ "<Control><Super>c" ];
      history-length = 500;
      incognito-shortcut = [ "<Control><Super>v" ];
      is-in-incognito = false;
      item-size = 200;
      keep-search-entry = false;
      open-links-in-browser = true;
      paste-on-select = false;
      play-audio-on-copy = false;
      send-notification-on-copy = false;
      show-indicator = false;
      sync-primary = false;
    };

    "org/gnome/shell/extensions/quick-settings-tweaks" = {
      list-buttons = "[{\"name\":\"SystemItem\",\"label\":null,\"visible\":true},{\"name\":\"OutputStreamSlider\",\"label\":null,\"visible\":true},{\"name\":\"InputStreamSlider\",\"label\":null,\"visible\":false},{\"name\":\"St_BoxLayout\",\"label\":null,\"visible\":true},{\"name\":\"BrightnessItem\",\"label\":null,\"visible\":true},{\"name\":\"NMWiredToggle\",\"label\":\"Wired\",\"visible\":true},{\"name\":\"NMWirelessToggle\",\"label\":\"Wi-Fi\",\"visible\":true},{\"name\":\"NMModemToggle\",\"label\":null,\"visible\":false},{\"name\":\"NMBluetoothToggle\",\"label\":\"Tether\",\"visible\":true},{\"name\":\"NMVpnToggle\",\"label\":\"VPN\",\"visible\":true},{\"name\":\"BluetoothToggle\",\"label\":\"Bluetooth\",\"visible\":true},{\"name\":\"PowerProfilesToggle\",\"label\":\"Power Mode\",\"visible\":false},{\"name\":\"NightLightToggle\",\"label\":\"Night Light\",\"visible\":true},{\"name\":\"DarkModeToggle\",\"label\":\"Dark Style\",\"visible\":true},{\"name\":\"RfkillToggle\",\"label\":\"Airplane Mode\",\"visible\":true},{\"name\":\"RotationToggle\",\"label\":\"Auto Rotate\",\"visible\":false},{\"name\":\"CaffeineToggle\",\"label\":\"Caffeine\",\"visible\":true},{\"name\":\"ServiceToggle\",\"label\":\"GSConnect\",\"visible\":true},{\"name\":\"DndQuickToggle\",\"label\":\"Do Not Disturb\",\"visible\":true},{\"name\":\"BackgroundAppsToggle\",\"label\":\"No Background Apps\",\"visible\":false},{\"name\":\"MediaSection\",\"label\":null,\"visible\":false},{\"name\":\"Notifications\",\"label\":null,\"visible\":true}]";
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
      alphabetize = true;
      battery-slot = 1;
      hot-sensors = [ "_processor_usage_" "_memory_usage_" "_temperature_amdgpu_edge_" "__network-rx_max__" "__network-tx_max__" ];
      include-static-info = false;
      show-battery = true;
    };

    "org/gnome/shell/keybindings" = {
      screenshot = [ "<Alt>Print" ];
      screenshot-window = [ "<Shift>Print" ];
      show-screenshot-ui = [ ];
      toggle-overview = [ ];
    };

    "org/gnome/shell/weather" = {
      automatic-location = true;
      locations = "[<(uint32 2, <('Bangalore', 'VOBG', true, [(0.22601989378717041, 1.3555659188172149)], [(0.22631101470640302, 1.3537937114947398)])>)>]";
    };

    "org/gnome/shell/world-clocks" = {
      locations = [ ];
    };

    "org/gnome/software" = {
      check-timestamp = mkInt64 1698808537;
      first-run = false;
      flatpak-purge-timestamp = mkInt64 1698816180;
      show-only-free-apps = true;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/gtk4/settings/color-chooser" = {
      custom-colors = [ (mkTuple [ 0.533333 0.752941 0.815686 1.0 ]) ];
      selected-color = mkTuple [ true 0.180392 0.760784 0.494118 1.0 ];
    };

    "org/gtk/gtk4/settings/emoji-chooser" = {
      recent-emoji = [ (mkTuple [ (mkTuple [ [ (mkUint32 128579) ] "upside-down face" [ "face" "upside-down" ] (mkUint32 0) ]) (mkUint32 0) ]) ];
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
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 212;
      sort-column = "modified";
      sort-directories-first = false;
      sort-order = "descending";
      type-format = "category";
      window-position = mkTuple [ 35 32 ];
      window-size = mkTuple [ 1203 902 ];
    };

  };
}
