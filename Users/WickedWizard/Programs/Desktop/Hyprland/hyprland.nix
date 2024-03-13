{
  #     extraConfig = ''
  #     # AGS
  # # bind  = , XF86Launch1, exec,
  # # Laptop
  # bindle = , XF86MonBrightnessUp,     exec, ags  -r "brightness.screen += 0.05; indicator.display()"
  # bindle = , XF86MonBrightnessDown,   exec, ags  -r "brightness.screen -= 0.05; indicator.display()"
  # bindle = , XF86KbdBrightnessUp,     exec, ags  -r "brightness.kbd++; indicator.kbd()"
  # bindle = , XF86KbdBrightnessDown,   exec, ags  -r "brightness.kbd--; indicator.kbd()"
  # bindle = , XF86AudioRaiseVolume,    exec, ags  -r "audio.speaker.volume += 0.02; indicator.speaker()"
  # bindle = , XF86AudioLowerVolume,    exec, ags  -r "audio.speaker.volume -= 0.02; indicator.speaker()"
  # bindl  = , XF86AudioPlay,           exec, ags  -r "mpris?.playPause()"
  # bindl  = , XF86AudioPrev,           exec, ags  -r "mpris?.previous()"
  # bindl  = , XF86AudioNext,           exec, ags  -r "mpris?.next()"
  # bindl  = , XF86AudioMicMute,        exec, ags  -r "audio.microphone.isMuted = !audio.microphone.isMuted"

  # # Launchers
  # SUPER, Q, exec, firefox
  # SUPER, F, exec, nautilus
  # SUPER SHIFT CTRL, L, exec, wlogout
  # SUPER SHIFT, V, exec, copyq menu
  # SUPER CTRL, W, exec, gtklock& sleep 3 && hyprctl dispatch dpms off
  # SUPER, A, exec, wofi

  # # Bindings

  # # Tabbed
  # bind= SUPER, g, togglegroup
  # bind= SUPER_SHIFT, g, lockgroups, toggle
  # bind= SUPER_CTRL, g, moveoutofgroup
  # bind= SUPER, Tab, changegroupactive
  # bind= SUPER_SHIFT, h, moveintogroup, l
  # bind= SUPER_SHIFT, l, moveintogroup, r
  # bind= SUPER_SHIFT, k, moveintogroup, u
  # bind= SUPER_SHIFT, j, moveintogroup, d


  # # Screen shot
  # bind=SUPERSHIFT, S, exec, grim -g "$(slurp)" - | swappy -f -
  # # OCR (Optical Character Recognition)
  # SUPER_SHIFT_CTRL, S, exec, grim -g "$(slurp)" "tmp.png" && tesseract-ocr "tmp.png" - | wl-copy && rm "tmp.png" && notify-send "OCR copied!"
  # layerrule = noanim, ^(selection)$
  # # OBS
  # CTRL_SUPER,F10,pass,^(com\.obsproject\.Studio)$

  # #Lock on lid close
  # #bindl=, switch:Lid Switch, exec, gtklock -i
  # monitor = eDP-1,1920x1080@60,0x0,1
  # #workspace = 1, monitor:eDP-1
  # #workspace = 2, monitor:eDP-2
  # windowrule = float, ^(Rofi)$
  # windowrule = float, ^(eww)$
  # windowrule = float, ^(nm-connection-editor)$
  # windowrule = float, ^(blueberry.py)$
  # windowrule = float, ^(org.gnome.Settings)$
  # windowrule = float, ^(org.gnome.design.Palette)$
  # windowrule = float, ^(Color Picker)$
  # windowrule = float, ^(Network)$
  # windowrule = float, ^(transmission-gtk)$
  # windowrule = float, ^(ags)$
  # windowrulev2 = maxsize 665,700, title:^(.*ags.*)$
  # windowrulev2 = move cursor -85% 0%, title:^(.*ags.*)$
  # windowrule = float, pavucontrol
  # windowrule = float, copyq

  # windowrulev2 = float, class:file-roller
  # windowrulev2 = float, title:^(Picture-in-Picture)$
  # windowrulev2 = float, title:^(Open Folder)$
  # windowrulev2 = float, class:^(firefox)$,title:^(Save File)$
  # windowrulev2 = float, class:^(firefox)$,title:^(Open File)$
  # windowrulev2 = float, class:^(firefox)$,title:^(Library)$
  # windowrulev2 = float, class:^(blueman-manager)$
  # windowrulev2 = float, class:^(org.twosheds.iwgtk)$
  # windowrulev2 = float, class:^(blueberry.py)$
  # windowrulev2 = float, class:^(xdg-desktop-portal-gtk)$
  # windowrulev2 = float, class:^(geeqie)$
  # windowrulev2 = float, title:^(.*Progress.*)$
  # windowrulev2 = float, title:^(.*Confirm.*)$
  # windowrulev2 = float, title:^(Friends List)$
  # windowrulev2 = float, title:^(Steam - News)$
  # windowrulev2 = float, title:^(Firefox — Sharing Indicator)$
  # windowrulev2 = float, class:^(.*waydroid.*)$
  # windowrulev2 = float, title:wlogout
  # windowrulev2 = float, title:^(.*Calculator.*)$
  # windowrulev2 = float, title:^(.*Properties.*)$
  # windowrulev2 = float, class:^(.*polkit.*)$

  # windowrulev2 = minsize 650,600, title:^(.*Calculator.*)$
  # windowrule = center, Calculator

  # windowrulev2 = dimaround,class:^(com.github.hluk.copyq)$
  # windowrulev2 = noborder,class:^(com.github.hluk.copyq)$

  # # Application Workspaces
  # windowrulev2 = workspace 1 silent, title:^(.*(Disc|WebC)ord.*)$
  # windowrule = workspace 1 silent, title:^(.*Firefox)$
  # windowrulev2 = tile, class:^(Spotify)$
  # windowrulev2 = workspace 4 silent, class:^(Spotify)$
  # windowrulev2 = workspace 3 silent, title:^(VSCodium|.*Lapce.*)$
  # windowrulev2 = workspace 5 silent, title:^(Steam|Lutris|.*Heroic.*|Prism.*)$
  # windowrulev2 = workspace 6, class:^(.*waydroid.*)$
  # windowrulev2 = workspace 4 silent, title:^(elisa|.*Amberol.*)$

  # # Layers
  # layerrule = blur, noanim
  # layerrule = blur, gtk-layer-shell
  # layerrule = ignorezero, gtk-layer-shell

  # # Tearing
  # #windowrulev2 = immediate, class:^(hl2_linux)$
  # #windowrulev2 = immediate,class:^(mpv)$

  # debug:overlay=0

  # #exec-once=dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP #&& systemctl --user start hyprland-session.target

  # #exec-once = dbus-update-activation-environment --all
  # # Responsible for imporitng environment variable for GTK applications
  # #exec-once = systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP
  # #exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
  # exec-once = pipewire

  # #exec-once = killall -q waybar;sleep .5 && waybar
  # exec-once = ags
  # #exec-once = /usr/libexec/polkit-gnome-authentication-agent-1
  # exec-once = /usr/libexec/xfce-polkit
  # #exec-once = ~/.profile
  # exec-once = mpd
  # exec-once = mpDris2
  # exec-once = gammastep
  # exec-once = copyq

  # #exec-once = swayidle -C ~/.config/swayidle/hyprland

  # # TEARING
  # #env = WLR_DRM_NO_ATOMIC,1

  # # XDG
  # env = XDG_CURRENT_DESKTOP,Hyprland
  # env = XDG_SESSION_TYPE,wayland
  # env = XDG_SESSION_DESKTOP,Hyprland

  # # QT
  # env = QT_AUTO_SCREEN_SCALE_FACTOR,1
  # env = QT_QPA_PLATFORM=wayland;xcb    # Not yet working for onlyoffice-editor
  # env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
  # env = QT_QPA_PLATFORMTHEME,qt6ct
  # env = QT_QPA_PLATFORMTHEME,qt5ct
  # env = QT_STYLE_OVERRIDE=kvantum

  # # Toolkit
  # #env = SDL_VIDEODRIVER,wayland
  # env = _JAVA_AWT_WM_NONEREPARENTING,1
  # env = CLUTTER_BACKEND,wayland
  # env = GDK_BACKEND,wayland,x11

  # # plugin = /usr/lib64/hyprland/libhyprbars.so
  # # plugin = /usr/lib64/hyprland/libborders-plus-plus.so

  # general {
  #     gaps_in = 3
  #     gaps_out = 5
  #     border_size = 1.75
  #     col.active_border = rgba(3d76a5FF)
  #     col.inactive_border = rgba(3d76a5FF)
  # }



  # group {
  #   col.border_active = rgba(46b2bdff)
  #   col.border_inactive = rgba(46b2bd99)
  #   col.border_locked_active = rgb(99, 143, 236)
  #   col.border_locked_inactive = rgb(77a2bb)

  #   groupbar {
  #     height = 10
  #     font_size = 10
  #     col.active = rgba(46b2bdff)
  #     col.inactive = rgba(46b2bd99)
  #     col.locked_active = rgba(cc0303ff)
  #     col.locked_inactive = rgba(467fbd88)
  #   }
  # }

  # animations {
  #   enabled = yes

  #   #bezier = md3_standard, 0.2, 0.0, 0, 1.0
  #   bezier = md3_decel, 0.05, 0.7, 0.1, 1
  #   #bezier = md3_accel, 0.3, 0, 0.8, 0.15
  #   bezier = buz, -0.09, 0, 0.19, 1
  #   bezier = linear, 0,0,1,1
  #   bezier = overshot,0.13,0.99,0.29,1.1
  #   #bezier = myBezier, 0.05, 0.9, 0.1, 1.05

  #   animation = windows, 1, 4, md3_decel
  #   animation = windowsMove, 1, 4, buz
  #   animation = windowsIn, 1, 4, overshot, popin 50%
  #   animation = windowsOut, 1, 4, md3_decel, popin
  #   animation = border, 1, 10, default
  #   animation = fade, 1, 7, default
  #   animation = workspaces, 1, 6, overshot, slide
  # }
  # '';
}
