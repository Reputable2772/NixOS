# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "apps/seahorse/listing" = {
      keyrings-selected = [ "gnupg://" ];
    };

    "apps/seahorse/windows/key-manager" = {
      height = 1010;
      width = 1920;
    };

    "com/github/GradienceTeam/Gradience" = {
      first-run = false;
      last-opened-version = "0.4.1";
      user-flatpak-theming-gtk4 = true;
      window-fullscreen = false;
      window-height = 700;
      window-maximized = false;
      window-width = 1000;
    };

    "com/github/wwmm/easyeffects" = {
      last-used-input-preset = "Presets";
      last-used-output-preset = "Presets";
    };

    "com/github/wwmm/easyeffects/spectrum" = {
      color = mkTuple [ 1.0 1.0 ];
      color-axis-labels = mkTuple [ 1.0 1.0 ];
    };

    "com/github/wwmm/easyeffects/streaminputs" = {
      input-device = "alsa_input.pci-0000_04_00.6.analog-stereo";
      plugins = [ "rnnoise#0" ];
      use-default-input-device = false;
    };

    "com/github/wwmm/easyeffects/streamoutputs" = {
      output-device = "bluez_output.41_42_4C_5C_BB_63.1";
      use-default-output-device = false;
    };

    "org/gnome/Console" = {
      last-window-size = mkTuple [ 652 481 ];
    };

    "org/gnome/GWeather4" = {
      temperature-unit = "centigrade";
    };

    "org/gnome/Weather" = {
      locations = "[<(uint32 2, <('Bangalore', 'VOBG', true, [(0.22601989378717041, 1.3555659188172149)], [(0.22631101470640302, 1.3537937114947398)])>)>]";
    };

    "org/gnome/calculator" = {
      accuracy = 9;
      angle-units = "degrees";
      base = 10;
      button-mode = "basic";
      number-format = "automatic";
      show-thousands = false;
      show-zeroes = false;
      source-currency = "";
      source-units = "degree";
      target-currency = "";
      target-units = "radian";
      word-size = 64;
    };

    "org/gnome/calendar" = {
      active-view = "month";
      window-maximized = true;
      window-size = mkTuple [ 768 600 ];
    };

    "org/gnome/control-center" = {
      last-panel = "removable-media";
      window-state = mkTuple [ 980 640 ];
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
      application-children = [ "org-gnome-shell-extensions-gsconnect" "librewolf" "firefox" "beeper" "gnome-power-panel" "obsidian" "com-obsproject-studio" "spotify" "org-flameshot-flameshot" "gnome-network-panel" "schildichat-desktop" "org-gnome-texteditor" ];
      show-in-lock-screen = true;
    };

    "org/gnome/desktop/notifications/application/beeper" = {
      application-id = "beeper.desktop";
    };

    "org/gnome/desktop/notifications/application/com-obsproject-studio" = {
      application-id = "com.obsproject.Studio.desktop";
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

    "org/gnome/desktop/notifications/application/librewolf" = {
      application-id = "librewolf.desktop";
    };

    "org/gnome/desktop/notifications/application/obsidian" = {
      application-id = "obsidian.desktop";
    };

    "org/gnome/desktop/notifications/application/org-flameshot-flameshot" = {
      application-id = "org.flameshot.Flameshot.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-shell-extensions-gsconnect" = {
      application-id = "org.gnome.Shell.Extensions.GSConnect.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-texteditor" = {
      application-id = "org.gnome.TextEditor.desktop";
    };

    "org/gnome/desktop/notifications/application/schildichat-desktop" = {
      application-id = "schildichat-desktop.desktop";
    };

    "org/gnome/desktop/notifications/application/spotify" = {
      application-id = "spotify.desktop";
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      numlock-state = true;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = 1.0;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
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
      enabled = [ "org.gnome.Weather.desktop" ];
      sort-order = [ "org.gnome.Contacts.desktop" "org.gnome.Documents.desktop" "org.gnome.Nautilus.desktop" ];
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
      switch-to-workspace-left = [ "<Control><Super>Left" ];
      switch-to-workspace-right = [ "<Control><Super>Right" ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
      toggle-fullscreen = [ "F11" ];
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
      window-ratio = mkTuple [ 0.979866 0.75772 ];
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = true;
    };

    "org/gnome/mutter/wayland/keybindings" = {
      restore-shortcuts = [ ];
    };

    "org/gnome/nautilus/icon-view" = {
      default-zoom-level = "small";
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

    "org/gnome/nm-applet/eap/0feb9aeb-a39e-49a0-ab66-dd40a7bb0bd5" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      calculator = [ "Calculator" ];
      control-center = [ "<Super>s" ];
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
      mic-mute = [ "F4" ];
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

    "org/gnome/shell" = {
      app-picker-layout = "[{'waydroid.com.android.inputmethod.latin.desktop': <{'position': <0>}>, 'org.gnome.Contacts.desktop': <{'position': <1>}>, 'org.gnome.Weather.desktop': <{'position': <2>}>, 'org.gnome.clocks.desktop': <{'position': <3>}>, 'org.gnome.Maps.desktop': <{'position': <4>}>, 'beeper.desktop': <{'position': <5>}>, 'bitwarden.desktop': <{'position': <6>}>, 'waydroid.org.lineageos.jelly.desktop': <{'position': <7>}>, 'org.gnome.Calculator.desktop': <{'position': <8>}>, 'waydroid.com.android.calculator2.desktop': <{'position': <9>}>, 'waydroid.org.lineageos.etar.desktop': <{'position': <10>}>, 'org.gnome.Settings.desktop': <{'position': <11>}>, 'gnome-system-monitor.desktop': <{'position': <12>}>, 'calibre-gui.desktop': <{'position': <13>}>, 'waydroid.com.android.camera2.desktop': <{'position': <14>}>, 'waydroid.com.android.deskclock.desktop': <{'position': <15>}>, 'org.gnome.Characters.desktop': <{'position': <16>}>, 'yelp.desktop': <{'position': <17>}>, 'waydroid.com.android.contacts.desktop': <{'position': <18>}>, 'calibre-ebook-edit.desktop': <{'position': <19>}>, 'org.gnome.font-viewer.desktop': <{'position': <20>}>, 'calibre-ebook-viewer.desktop': <{'position': <21>}>, 'com.github.wwmm.easyeffects.desktop': <{'position': <22>}>, 'org.gnome.Extensions.desktop': <{'position': <23>}>}, {'waydroid.com.android.documentsui.desktop': <{'position': <0>}>, 'firefox.desktop': <{'position': <1>}>, 'org.flameshot.Flameshot.desktop': <{'position': <2>}>, 'waydroid.com.android.gallery3d.desktop': <{'position': <3>}>, 'com.github.GradienceTeam.Gradience.desktop': <{'position': <4>}>, 'kitty.desktop': <{'position': <5>}>, 'kvantummanager.desktop': <{'position': <6>}>, 'librewolf.desktop': <{'position': <7>}>, 'calibre-lrfviewer.desktop': <{'position': <8>}>, 'waydroid.org.lineageos.eleven.desktop': <{'position': <9>}>, 'nheko.desktop': <{'position': <10>}>, 'nixos-manual.desktop': <{'position': <11>}>, 'com.obsproject.Studio.desktop': <{'position': <12>}>, 'obsidian.desktop': <{'position': <13>}>, 'qt5ct.desktop': <{'position': <14>}>, 'qt6ct.desktop': <{'position': <15>}>, 'waydroid.org.lineageos.recorder.desktop': <{'position': <16>}>, 'schildichat-desktop.desktop': <{'position': <17>}>, 'waydroid.com.android.settings.desktop': <{'position': <18>}>, 'spotify.desktop': <{'position': <19>}>, 'org.gnome.TextEditor.desktop': <{'position': <20>}>, 'vlc.desktop': <{'position': <21>}>, 'codium.desktop': <{'position': <22>}>, 'Waydroid.desktop': <{'position': <23>}>}, {'org.gnome.FileRoller.desktop': <{'position': <0>}>, 'org.gnome.Connections.desktop': <{'position': <1>}>, 'org.gnome.Console.desktop': <{'position': <2>}>, 'org.gnome.baobab.desktop': <{'position': <3>}>, 'org.gnome.DiskUtility.desktop': <{'position': <4>}>, 'org.gnome.Evince.desktop': <{'position': <5>}>, 'org.gnome.eog.desktop': <{'position': <6>}>, 'org.gnome.Logs.desktop': <{'position': <7>}>, 'org.gnome.seahorse.Application.desktop': <{'position': <8>}>}]";
      disable-user-extensions = false;
      disabled-extensions = [ ];
      enabled-extensions = [ "appindicatorsupport@rgcjonas.gmail.com" "clipboard-indicator@tudmotu.com" "gsconnect@andyholmes.github.io" "user-theme@gnome-shell-extensions.gcampax.github.com" "bluetooth-battery@michalw.github.com" ];
      welcome-dialog-last-shown-version = "44.4";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/shell/extensions/bluetooth_battery_indicator" = {
      devices = [
        ''
          {"name":"Boult Audio Probass","alias":"Boult Audio Probass","isConnected":true,"isPaired":true,"mac":"41:42:4C:5C:BB:63","isDefault":false,"defaultIcon":"audio-headset","percentageSource":"upower","active":true,"icon":"audio-headphones-symbolic"}
        ''
      ];
      hide-indicator = true;
      interval = 1;
    };

    "org/gnome/shell/extensions/clipboard-indicator" = {
      confirm-clear = true;
      next-entry = [ "<Shift><Control><Alt>y" ];
      notify-on-copy = false;
      prev-entry = [ "<Shift><Control><Alt>z" ];
      toggle-menu = [ "<Shift><Control><Alt>a" ];
    };

    "org/gnome/shell/extensions/gsconnect" = {
      devices = [ "d78abea8_98dc_4f3b_9b34_102ef2b16e5d" ];
      id = "43515925-5fe7-495b-adb0-7ad321ef7803";
      name = "nixos";
    };

    "org/gnome/shell/extensions/gsconnect/device/d78abea8_98dc_4f3b_9b34_102ef2b16e5d" = {
      incoming-capabilities = [ "kdeconnect.battery" "kdeconnect.bigscreen.stt" "kdeconnect.clipboard" "kdeconnect.clipboard.connect" "kdeconnect.contacts.request_all_uids_timestamps" "kdeconnect.contacts.request_vcards_by_uid" "kdeconnect.findmyphone.request" "kdeconnect.mousepad.keyboardstate" "kdeconnect.mousepad.request" "kdeconnect.mpris" "kdeconnect.mpris.request" "kdeconnect.notification" "kdeconnect.notification.action" "kdeconnect.notification.reply" "kdeconnect.notification.request" "kdeconnect.photo.request" "kdeconnect.ping" "kdeconnect.runcommand" "kdeconnect.sftp.request" "kdeconnect.share.request" "kdeconnect.share.request.update" "kdeconnect.sms.request" "kdeconnect.sms.request_attachment" "kdeconnect.sms.request_conversation" "kdeconnect.sms.request_conversations" "kdeconnect.systemvolume" "kdeconnect.telephony.request" "kdeconnect.telephony.request_mute" ];
      last-connection = "lan://192.168.0.103:1716";
      name = "Redmi  S2";
      outgoing-capabilities = [ "kdeconnect.battery" "kdeconnect.bigscreen.stt" "kdeconnect.clipboard" "kdeconnect.clipboard.connect" "kdeconnect.connectivity_report" "kdeconnect.contacts.response_uids_timestamps" "kdeconnect.contacts.response_vcards" "kdeconnect.findmyphone.request" "kdeconnect.mousepad.echo" "kdeconnect.mousepad.keyboardstate" "kdeconnect.mousepad.request" "kdeconnect.mpris" "kdeconnect.mpris.request" "kdeconnect.notification" "kdeconnect.notification.request" "kdeconnect.photo" "kdeconnect.ping" "kdeconnect.presenter" "kdeconnect.runcommand.request" "kdeconnect.sftp" "kdeconnect.share.request" "kdeconnect.sms.attachment_file" "kdeconnect.sms.messages" "kdeconnect.systemvolume.request" "kdeconnect.telephony" ];
      paired = true;
      supported-plugins = [ "battery" "clipboard" "connectivity_report" "contacts" "findmyphone" "mousepad" "mpris" "notification" "photo" "ping" "presenter" "runcommand" "sftp" "share" "sms" "systemvolume" "telephony" ];
      type = "phone";
    };

    "org/gnome/shell/extensions/gsconnect/device/d78abea8_98dc_4f3b_9b34_102ef2b16e5d/plugin/battery" = {
      custom-battery-notification-value = mkUint32 80;
    };

    "org/gnome/shell/extensions/gsconnect/device/d78abea8_98dc_4f3b_9b34_102ef2b16e5d/plugin/clipboard" = {
      receive-content = true;
      send-content = true;
    };

    "org/gnome/shell/extensions/gsconnect/device/d78abea8_98dc_4f3b_9b34_102ef2b16e5d/plugin/notification" = {
      applications = ''
        {"Beeper":{"iconName":"","enabled":true},"SchildiChat":{"iconName":"","enabled":true}}\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\n\\\\\\\\\\\\\\\\n\\\\\\\\n\\\\n\\n\n
      '';
    };

    "org/gnome/shell/extensions/gsconnect/device/d78abea8_98dc_4f3b_9b34_102ef2b16e5d/plugin/share" = {
      receive-directory = "/home/wickedwizard/Downloads";
    };

    "org/gnome/shell/extensions/gsconnect/preferences" = {
      window-maximized = true;
      window-size = mkTuple [ 783 440 ];
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "";
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
      locations = "@av []";
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 175;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [ 30 26 ];
      window-size = mkTuple [ 1203 902 ];
    };

  };
}
