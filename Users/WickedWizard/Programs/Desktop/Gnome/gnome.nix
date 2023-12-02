# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "ca/desrt/dconf-editor" = {
      saved-pathbar-path = "/org/gnome/shell/extensions/gsconnect/device/d78abea8_98dc_4f3b_9b34_102ef2b16e5d/keybindings";
      saved-view = "/org/gnome/shell/extensions/gsconnect/device/d78abea8_98dc_4f3b_9b34_102ef2b16e5d/keybindings";
      window-height = 500;
      window-is-maximized = true;
      window-width = 540;
    };

    "com/github/GradienceTeam/Gradience" = {
      enabled-plugins = [ "firefox_gnome_theme" ];
      first-run = false;
      last-opened-version = "0.4.1";
      window-fullscreen = false;
      window-height = 700;
      window-maximized = true;
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

    "com/github/wwmm/easyeffects/streamoutputs/stereotools/0" = {
      softclip = true;
    };

    "com/usebottles/bottles" = {
      show-sandbox-warning = false;
      startup-view = "page_list";
      window-height = 1048;
      window-width = 1920;
    };

    "io/github/lainsce/Khronos" = {
      schema-version = 1;
    };

    "io/github/seadve/Kooha" = {
      profile-id = "gif";
      record-mic = false;
      record-speaker = false;
      screencast-restore-token = "27797ad8-9dc2-4b92-984c-4dd10aaed345";
      show-pointer = false;
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

    "org/freedesktop/tracker/miner/files" = {
      index-recursive-directories = [ "&DESKTOP" "&DOCUMENTS" ];
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
      window-height = 416;
      window-maximized = true;
      window-width = 992;
    };

    "org/gnome/baobab/ui" = {
      is-maximized = false;
      window-size = mkTuple [ 960 600 ];
    };

    "org/gnome/boxes" = {
      first-run = false;
      view = "icon-view";
      window-maximized = true;
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

    "org/gnome/control-center" = {
      last-panel = "power";
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

    "org/gnome/desktop/background" = {
      show-desktop-icons = true;
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
      clock-show-seconds = true;
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      cursor-theme = "Nordic-cursors";
      enable-animations = true;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      gtk-theme = "Nordic-darker";
      icon-theme = "MoreWaita";
      locate-pointer = false;
      show-battery-percentage = true;
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "org-gnome-shell-extensions-gsconnect" "librewolf" "firefox" "beeper" "gnome-power-panel" "obsidian" "com-obsproject-studio" "spotify" "org-flameshot-flameshot" "gnome-network-panel" "schildichat-desktop" "org-gnome-texteditor" "org-gnome-console" "codium" "org-gnome-maps" "org-gnome-evince" "kitty" "org-gnome-eog" "org-gnome-characters" "org-gnome-nautilus" "ca-desrt-dconf-editor" "io-gitlab-news-flash-newsflash" "bitwarden" "-joplinapp-desktop" "de-haeckerfelix-fragments" "mullvadbrowser" "org-gnome-settings" "thunderbird" "org-telegram-desktop" "chromium-browser" "org-gnome-podcasts" "steam" "com-usebottles-bottles" "vlc" "com-github-gradienceteam-gradience" "io-github-martinrotter-rssguard" "org-gnome-clocks" "signal-desktop" "org-gnome-todo" "io-github-mrvladus-list" "org-gnome-software" "deluge" "org-gnome-baobab" "org-gnome-fractal" "org-gnome-evolution-alarm-notify" "calibre-gui" "discord" "com-github-vladimiry-electronmail" ];
      show-banners = false;
      show-in-lock-screen = true;
    };

    "org/gnome/desktop/notifications/application/-joplinapp-desktop" = {
      application-id = "@joplinapp-desktop.desktop";
    };

    "org/gnome/desktop/notifications/application/armcord" = {
      application-id = "armcord.desktop";
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

    "org/gnome/desktop/notifications/application/calibre-gui" = {
      application-id = "calibre-gui.desktop";
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

    "org/gnome/desktop/notifications/application/com-github-vladimiry-electronmail" = {
      application-id = "com.github.vladimiry.ElectronMail.desktop";
    };

    "org/gnome/desktop/notifications/application/com-obsproject-studio" = {
      application-id = "com.obsproject.Studio.desktop";
    };

    "org/gnome/desktop/notifications/application/com-ranfdev-notify" = {
      application-id = "com.ranfdev.Notify.desktop";
    };

    "org/gnome/desktop/notifications/application/com-usebottles-bottles" = {
      application-id = "com.usebottles.bottles.desktop";
    };

    "org/gnome/desktop/notifications/application/de-haeckerfelix-fragments" = {
      application-id = "de.haeckerfelix.Fragments.desktop";
    };

    "org/gnome/desktop/notifications/application/deluge" = {
      application-id = "deluge.desktop";
    };

    "org/gnome/desktop/notifications/application/discord" = {
      application-id = "discord.desktop";
    };

    "org/gnome/desktop/notifications/application/draw" = {
      application-id = "draw.desktop";
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

    "org/gnome/desktop/notifications/application/io-github-martinrotter-rssguard" = {
      application-id = "io.github.martinrotter.rssguard.desktop";
    };

    "org/gnome/desktop/notifications/application/io-github-mrvladus-list" = {
      application-id = "io.github.mrvladus.List.desktop";
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

    "org/gnome/desktop/notifications/application/org-gnome-baobab" = {
      application-id = "org.gnome.baobab.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-characters" = {
      application-id = "org.gnome.Characters.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-clocks" = {
      application-id = "org.gnome.clocks.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-console" = {
      application-id = "org.gnome.Console.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-contacts" = {
      application-id = "org.gnome.Contacts.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-eog" = {
      application-id = "org.gnome.eog.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-epiphany" = {
      application-id = "org.gnome.Epiphany.desktop";
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

    "org/gnome/desktop/notifications/application/org-gnome-software" = {
      application-id = "org.gnome.Software.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-texteditor" = {
      application-id = "org.gnome.TextEditor.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-todo" = {
      application-id = "org.gnome.Todo.desktop";
    };

    "org/gnome/desktop/notifications/application/org-telegram-desktop" = {
      application-id = "org.telegram.desktop.desktop";
    };

    "org/gnome/desktop/notifications/application/schildichat-desktop" = {
      application-id = "schildichat-desktop.desktop";
    };

    "org/gnome/desktop/notifications/application/signal-desktop" = {
      application-id = "signal-desktop.desktop";
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

    "org/gnome/epiphany/web" = {
      enable-mouse-gestures = true;
      enable-user-js = false;
    };

    "org/gnome/evince/default" = {
      continuous = true;
      dual-page = false;
      dual-page-odd-left = true;
      enable-spellchecking = true;
      fullscreen = false;
      inverted-colors = true;
      show-sidebar = true;
      sidebar-page = "thumbnails";
      sidebar-size = 132;
      sizing-mode = "fit-width";
      window-ratio = mkTuple [ 0.9798657718120806 0.661520190023753 ];
      zoom = 1.0726802115185157;
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
    };

    "org/gnome/evolution-data-server/calendar" = {
      reminders-past = [ "4e68caa2d3b1640cdfdcf5cdd894444912b501bb16319b6eda4320acf59aeef48817e9678373bf39t20231202170147520017014752001701475200BEGIN:VTODOrDTSTAMP:20231201T165057ZrUID:842789900856251318rSEQUENCE:2rCREATED:20231125T152810ZrLAST-MODIFIED:20231201T123520ZrSUMMARY:CLAT Admit CardrDESCRIPTION:CLAT Admit Card PrintoutrPRIORITY:1rSTATUS:NEEDS-ACTIONrRRULE:FREQ=DAILYrX-APPLE-SORT-ORDER:719765955rX-MOZ-LASTACK:20231130T113327ZrDUE;VALUE=DATE:20231202rDTSTART;VALUE=DATE:20231202rX-EVOLUTION-CALDAV-ETAG:4430d5d07e255364b5238a5f79d1ddb0rRECURRENCE-ID;VALUE=DATE:20231202rDTEND;VALUE=DATE:20231202rBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:16319b6eda4320acf59aeef48817e9678373bf39rEND:VALARMrEND:VTODOr" "16669dd59a5baadbcec39840a104bcdf72a3b89d17147839f94903f2fc903eb37fa48717afecf323t20231202170147520017014752001701475200BEGIN:VTODOrDTSTAMP:20231201T165057ZrUID:842789900856251318rSEQUENCE:2rCREATED:20231125T152810ZrLAST-MODIFIED:20231201T123520ZrSUMMARY:CLAT Admit CardrDESCRIPTION:CLAT Admit Card PrintoutrPRIORITY:1rSTATUS:NEEDS-ACTIONrRRULE:FREQ=DAILYrX-APPLE-SORT-ORDER:719765955rX-MOZ-LASTACK:20231130T113327ZrDUE;VALUE=DATE:20231202rDTSTART;VALUE=DATE:20231202rX-EVOLUTION-CALDAV-ETAG:4430d5d07e255364b5238a5f79d1ddb0rRECURRENCE-ID;VALUE=DATE:20231202rDTEND;VALUE=DATE:20231202rBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:17147839f94903f2fc903eb37fa48717afecf323rEND:VALARMrEND:VTODOr" "16669dd59a5baadbcec39840a104bcdf72a3b89dc61c7eb19ca3b8d33ec3d95df4c2e2cac97db466t20231201170138880017013888001701388800BEGIN:VTODOrDTSTAMP:20231128T123021ZrUID:842789900856251318rSEQUENCE:1rCREATED:20231125T152810ZrLAST-MODIFIED:20231128T113535ZrSUMMARY:CLAT Admit CardrDESCRIPTION:CLAT Admit Card PrintoutrPRIORITY:1rSTATUS:NEEDS-ACTIONrRRULE:FREQ=DAILYrX-APPLE-SORT-ORDER:719765955rX-MOZ-LASTACK:20231127T123014ZrDUE;VALUE=DATE:20231128rDTSTART;VALUE=DATE:20231201rX-EVOLUTION-CALDAV-ETAG:92efbe174abeeb64672a5d37d2dfb4c6rRECURRENCE-ID;VALUE=DATE:20231201rDTEND;VALUE=DATE:20231201rBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:c61c7eb19ca3b8d33ec3d95df4c2e2cac97db466rEND:VALARMrEND:VTODOr" "4e68caa2d3b1640cdfdcf5cdd894444912b501bb7b35e4a129bba6aad44d1bdbe261a64bbd6982d6t20231201170138880017013888001701388800BEGIN:VTODOrDTSTAMP:20231128T123021ZrUID:842789900856251318rSEQUENCE:1rCREATED:20231125T152810ZrLAST-MODIFIED:20231128T113535ZrSUMMARY:CLAT Admit CardrDESCRIPTION:CLAT Admit Card PrintoutrPRIORITY:1rSTATUS:NEEDS-ACTIONrRRULE:FREQ=DAILYrX-APPLE-SORT-ORDER:719765955rX-MOZ-LASTACK:20231127T123014ZrDUE;VALUE=DATE:20231128rDTSTART;VALUE=DATE:20231201rX-EVOLUTION-CALDAV-ETAG:92efbe174abeeb64672a5d37d2dfb4c6rRECURRENCE-ID;VALUE=DATE:20231201rDTEND;VALUE=DATE:20231201rBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:7b35e4a129bba6aad44d1bdbe261a64bbd6982d6rEND:VALARMrEND:VTODOr" "16669dd59a5baadbcec39840a104bcdf72a3b89d4d5b36b5167c4c68d8f40a37af8585feed3ed723t20231130T203000170135640117013564001701356401BEGIN:VTODOrDTSTAMP:20231129T150306ZrUID:1294331700948191936rSEQUENCE:6rCREATED:20231025T155852ZrLAST-MODIFIED:20231129T150212ZrSUMMARY:Take Tab from SmallyrPRIORITY:1rSTATUS:NEEDS-ACTIONrRRULE:FREQ=DAILYrX-APPLE-SORT-ORDER:719765958rDUE;TZID=Asia/Kolkata:20231130T203001rDTSTART;TZID=Asia/Kolkata:20231130T203000rX-EVOLUTION-CALDAV-ETAG:4cd088e4a04af8bff1cfd1a77165a933rRECURRENCE-ID;TZID=Asia/Kolkata:20231130T203000rDTEND;TZID=Asia/Kolkata:20231130T203001rBEGIN:VALARMrTRIGGER;RELATED=START:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:26c05d41d6598d5b924d6ab0e9477e28a8d7fe73rEND:VALARMrBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:4d5b36b5167c4c68d8f40a37af8585feed3ed723rEND:VALARMrEND:VTODOr" "16669dd59a5baadbcec39840a104bcdf72a3b89d26c05d41d6598d5b924d6ab0e9477e28a8d7fe73t20231130T203000170135640017013564001701356401BEGIN:VTODOrDTSTAMP:20231129T150306ZrUID:1294331700948191936rSEQUENCE:6rCREATED:20231025T155852ZrLAST-MODIFIED:20231129T150212ZrSUMMARY:Take Tab from SmallyrPRIORITY:1rSTATUS:NEEDS-ACTIONrRRULE:FREQ=DAILYrX-APPLE-SORT-ORDER:719765958rDUE;TZID=Asia/Kolkata:20231130T203001rDTSTART;TZID=Asia/Kolkata:20231130T203000rX-EVOLUTION-CALDAV-ETAG:4cd088e4a04af8bff1cfd1a77165a933rRECURRENCE-ID;TZID=Asia/Kolkata:20231130T203000rDTEND;TZID=Asia/Kolkata:20231130T203001rBEGIN:VALARMrTRIGGER;RELATED=START:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:26c05d41d6598d5b924d6ab0e9477e28a8d7fe73rEND:VALARMrBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:4d5b36b5167c4c68d8f40a37af8585feed3ed723rEND:VALARMrEND:VTODOr" "16669dd59a5baadbcec39840a104bcdf72a3b89dc61c7eb19ca3b8d33ec3d95df4c2e2cac97db466t20231130170130240017013024001701302400BEGIN:VTODOrDTSTAMP:20231128T123021ZrUID:842789900856251318rSEQUENCE:1rCREATED:20231125T152810ZrLAST-MODIFIED:20231128T113535ZrSUMMARY:CLAT Admit CardrDESCRIPTION:CLAT Admit Card PrintoutrPRIORITY:1rSTATUS:NEEDS-ACTIONrRRULE:FREQ=DAILYrX-APPLE-SORT-ORDER:719765955rX-MOZ-LASTACK:20231127T123014ZrDUE;VALUE=DATE:20231128rDTSTART;VALUE=DATE:20231130rX-EVOLUTION-CALDAV-ETAG:92efbe174abeeb64672a5d37d2dfb4c6rRECURRENCE-ID;VALUE=DATE:20231130rDTEND;VALUE=DATE:20231130rBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:c61c7eb19ca3b8d33ec3d95df4c2e2cac97db466rEND:VALARMrEND:VTODOr" "4e68caa2d3b1640cdfdcf5cdd894444912b501bb454ed52d9c9d5f272de345a23d59f0af1185dd96t20231130T203000170135640117013564001701356401BEGIN:VTODOrDTSTAMP:20231129T150306ZrUID:1294331700948191936rSEQUENCE:6rCREATED:20231025T155852ZrLAST-MODIFIED:20231129T150212ZrSUMMARY:Take Tab from SmallyrPRIORITY:1rSTATUS:NEEDS-ACTIONrRRULE:FREQ=DAILYrX-APPLE-SORT-ORDER:719765958rDUE;TZID=Asia/Kolkata:20231130T203001rDTSTART;TZID=Asia/Kolkata:20231130T203000rX-EVOLUTION-CALDAV-ETAG:4cd088e4a04af8bff1cfd1a77165a933rRECURRENCE-ID;TZID=Asia/Kolkata:20231130T203000rDTEND;TZID=Asia/Kolkata:20231130T203001rBEGIN:VALARMrTRIGGER;RELATED=START:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:789116227320cdcf9e3e69e5afa9a85f08b26d8drEND:VALARMrBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:454ed52d9c9d5f272de345a23d59f0af1185dd96rEND:VALARMrEND:VTODOr" "4e68caa2d3b1640cdfdcf5cdd894444912b501bb789116227320cdcf9e3e69e5afa9a85f08b26d8dt20231130T203000170135640017013564001701356401BEGIN:VTODOrDTSTAMP:20231129T150306ZrUID:1294331700948191936rSEQUENCE:6rCREATED:20231025T155852ZrLAST-MODIFIED:20231129T150212ZrSUMMARY:Take Tab from SmallyrPRIORITY:1rSTATUS:NEEDS-ACTIONrRRULE:FREQ=DAILYrX-APPLE-SORT-ORDER:719765958rDUE;TZID=Asia/Kolkata:20231130T203001rDTSTART;TZID=Asia/Kolkata:20231130T203000rX-EVOLUTION-CALDAV-ETAG:4cd088e4a04af8bff1cfd1a77165a933rRECURRENCE-ID;TZID=Asia/Kolkata:20231130T203000rDTEND;TZID=Asia/Kolkata:20231130T203001rBEGIN:VALARMrTRIGGER;RELATED=START:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:789116227320cdcf9e3e69e5afa9a85f08b26d8drEND:VALARMrBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:454ed52d9c9d5f272de345a23d59f0af1185dd96rEND:VALARMrEND:VTODOr" "4e68caa2d3b1640cdfdcf5cdd894444912b501bb7b35e4a129bba6aad44d1bdbe261a64bbd6982d6t20231130170130240017013024001701302400BEGIN:VTODOrDTSTAMP:20231128T123021ZrUID:842789900856251318rSEQUENCE:1rCREATED:20231125T152810ZrLAST-MODIFIED:20231128T113535ZrSUMMARY:CLAT Admit CardrDESCRIPTION:CLAT Admit Card PrintoutrPRIORITY:1rSTATUS:NEEDS-ACTIONrRRULE:FREQ=DAILYrX-APPLE-SORT-ORDER:719765955rX-MOZ-LASTACK:20231127T123014ZrDUE;VALUE=DATE:20231128rDTSTART;VALUE=DATE:20231130rX-EVOLUTION-CALDAV-ETAG:92efbe174abeeb64672a5d37d2dfb4c6rRECURRENCE-ID;VALUE=DATE:20231130rDTEND;VALUE=DATE:20231130rBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:7b35e4a129bba6aad44d1bdbe261a64bbd6982d6rEND:VALARMrEND:VTODOr" "4e68caa2d3b1640cdfdcf5cdd894444912b501bb98577e565c077fbc29a8011ea391dddd44fdd8c6t20231128170112960017011296001701129600BEGIN:VTODOrDTSTAMP:20231125T152811ZrUID:842789900856251318rCREATED:20231125T152810ZrLAST-MODIFIED:20231125T152810ZrSUMMARY:CLAT Admit CardrDESCRIPTION:CLAT Admit Card PrintoutrPRIORITY:1rSTATUS:NEEDS-ACTIONrRRULE:FREQ=DAILYrX-APPLE-SORT-ORDER:719765955rDUE;VALUE=DATE:20231127rDTSTART;VALUE=DATE:20231128rX-EVOLUTION-CALDAV-ETAG:c2432bbcf250deff5a0137454bd44bc2rRECURRENCE-ID;VALUE=DATE:20231128rDTEND;VALUE=DATE:20231128rBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:98577e565c077fbc29a8011ea391dddd44fdd8c6rEND:VALARMrEND:VTODOr" "16669dd59a5baadbcec39840a104bcdf72a3b89d0403ff351ae5eee0bf5200dcb489e546734c9ca5t20231128170112960017011296001701129600BEGIN:VTODOrDTSTAMP:20231125T152811ZrUID:842789900856251318rCREATED:20231125T152810ZrLAST-MODIFIED:20231125T152810ZrSUMMARY:CLAT Admit CardrDESCRIPTION:CLAT Admit Card PrintoutrPRIORITY:1rSTATUS:NEEDS-ACTIONrRRULE:FREQ=DAILYrX-APPLE-SORT-ORDER:719765955rDUE;VALUE=DATE:20231127rDTSTART;VALUE=DATE:20231128rX-EVOLUTION-CALDAV-ETAG:c2432bbcf250deff5a0137454bd44bc2rRECURRENCE-ID;VALUE=DATE:20231128rDTEND;VALUE=DATE:20231128rBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:0403ff351ae5eee0bf5200dcb489e546734c9ca5rEND:VALARMrEND:VTODOr" "4e68caa2d3b1640cdfdcf5cdd894444912b501bb98577e565c077fbc29a8011ea391dddd44fdd8c6t20231127170104320017010432001701043200BEGIN:VTODOrDTSTAMP:20231125T152811ZrUID:842789900856251318rCREATED:20231125T152810ZrLAST-MODIFIED:20231125T152810ZrSUMMARY:CLAT Admit CardrDESCRIPTION:CLAT Admit Card PrintoutrPRIORITY:1rSTATUS:NEEDS-ACTIONrRRULE:FREQ=DAILYrX-APPLE-SORT-ORDER:719765955rDUE;VALUE=DATE:20231127rDTSTART;VALUE=DATE:20231127rX-EVOLUTION-CALDAV-ETAG:c2432bbcf250deff5a0137454bd44bc2rRECURRENCE-ID;VALUE=DATE:20231127rDTEND;VALUE=DATE:20231127rBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:98577e565c077fbc29a8011ea391dddd44fdd8c6rEND:VALARMrEND:VTODOr" "16669dd59a5baadbcec39840a104bcdf72a3b89d0403ff351ae5eee0bf5200dcb489e546734c9ca5t20231127170104320017010432001701043200BEGIN:VTODOrDTSTAMP:20231125T152811ZrUID:842789900856251318rCREATED:20231125T152810ZrLAST-MODIFIED:20231125T152810ZrSUMMARY:CLAT Admit CardrDESCRIPTION:CLAT Admit Card PrintoutrPRIORITY:1rSTATUS:NEEDS-ACTIONrRRULE:FREQ=DAILYrX-APPLE-SORT-ORDER:719765955rDUE;VALUE=DATE:20231127rDTSTART;VALUE=DATE:20231127rX-EVOLUTION-CALDAV-ETAG:c2432bbcf250deff5a0137454bd44bc2rRECURRENCE-ID;VALUE=DATE:20231127rDTEND;VALUE=DATE:20231127rBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:0403ff351ae5eee0bf5200dcb489e546734c9ca5rEND:VALARMrEND:VTODOr" "4e68caa2d3b1640cdfdcf5cdd894444912b501bbfa41a7c2cb13627b436636073101b4ec9217e09bt20231125T000000170093250117008506001700932501BEGIN:VTODOrDTSTAMP:20231125T152600ZrUID:495525802399598198rCREATED:20231125T152600ZrLAST-MODIFIED:20231125T152600ZrSUMMARY:NSErDESCRIPTION:Prepare bag for NSErPRIORITY:1rSTATUS:NEEDS-ACTIONrX-APPLE-SORT-ORDER:719765957rDUE;TZID=Asia/Kolkata:20231125T224501rDTSTART;TZID=Asia/Kolkata:20231125T000000rX-EVOLUTION-CALDAV-ETAG:f09e4fac291eb7442fda1797439fb35brBEGIN:VALARMrTRIGGER;RELATED=END:PT0SrACTION:DISPLAYrDESCRIPTION:Default Tasks.org descriptionrX-EVOLUTION-ALARM-UID:fa41a7c2cb13627b436636073101b4ec9217e09brEND:VALARMrEND:VTODOr" ];
    };

    "org/gnome/evolution" = {
      default-address-book = "05eaed4a46fe4e16938eadee7aa85957e6f379ac";
      default-calendar = "3e01427c011feac5c9644676fb52bd9dc1478282";
      default-task-list = "system-task-list";
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
      restore-shortcuts = [];
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

    "org/gnome/portal/filechooser/kitty" = {
      last-folder-path = "/home/wickedwizard/Mounted/Important-Files/Exams";
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
      night-light-enabled = true;
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
      devices = [ ''
        {"name":"Redmi S2","alias":"Redmi S2","isConnected":false,"isPaired":true,"mac":"08:25:25:A0:40:49","isDefault":false,"defaultIcon":"phone"}
      '' ''
        {"name":"Boult Audio Probass","alias":"Boult Audio Probass","isConnected":false,"isPaired":true,"mac":"41:42:4C:5C:BB:63","isDefault":false,"defaultIcon":"audio-headset","percentageSource":"upower","icon":"audio-headphones-symbolic","active":true}
      '' ''
        {"name":"test","alias":"test","isConnected":false,"isPaired":false,"mac":"test","isDefault":false,"defaultIcon":"audio-headset","percentageSource":"upower","active":true,"icon":"audio-headphones-symbolic"}
      '' ];
      hide-indicator = true;
      interval = 1;
    };

    "org/gnome/shell/extensions/caffeine" = {
      indicator-position-max = 1;
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
      # keybindings = {
      #   clipboardPull = "<Shift><Super>Z";
      #   clipboardPush = "<Shift><Super>X";
      # };
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
      history-length = 500;
      item-size = 200;
      keep-search-entry = false;
      open-links-in-browser = true;
      play-audio-on-copy = false;
      send-notification-on-copy = false;
      show-indicator = false;
      sync-primary = true;
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

    "org/gnome/software" = {
      check-timestamp = mkInt64 1698808537;
      first-run = false;
      flatpak-purge-timestamp = mkInt64 1698816180;
      show-only-free-apps = true;
    };

    "org/gnome/system/location" = {
      enabled = false;
    };

    "org/gnome/todo" = {
      default-provider = "local";
      window-maximized = true;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/gtk4/settings/color-chooser" = {
      custom-colors = [ (mkTuple [ 0.533333 0.752941 0.815686 1.0 ]) ];
      selected-color = mkTuple [ true 0.180392 0.760784 0.494118 1.0 ];
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
      window-position = mkTuple [ 30 26 ];
      window-size = mkTuple [ 1203 902 ];
    };

    "org/x/hypnotix" = {
      active-provider = "Index";
      providers = [ "Free-TV:::url:::https://raw.githubusercontent.com/Free-TV/IPTV/master/playlist.m3u8:::::::::" "Index:::url:::https://iptv-org.github.io/iptv/index.nsfw.m3u:::::::::" "India:::url:::https://iptv-org.github.io/iptv/countries/in.m3u:::::::::" ];
    };

    "re/sonny/Tangram" = {
      instances = [ "ad343e600c964f319aaf977ee4daebcb" "3dfc923f6b8f447bb892c051b6466cb1" ];
      window-maximized = true;
    };

    "re/sonny/Tangram/instances/3dfc923f6b8f447bb892c051b6466cb1" = {
      name = "Matrix.org";
      url = "https://matrix.org/";
    };

    "re/sonny/Tangram/instances/ad343e600c964f319aaf977ee4daebcb" = {
      name = "Beeper";
      url = "https://chat.beeper.com/index.html";
    };

  };
}
