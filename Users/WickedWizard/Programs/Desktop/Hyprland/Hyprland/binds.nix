{ config, lib, pkgs, ... }: {
  home.packages = lib.mkIf (config.wayland.windowManager.hyprland.enable) (with pkgs; [
    brightnessctl
    libnotify
  ]);

  wayland.windowManager.hyprland.settings = {
    bind =
      let
        num = [ 1 2 3 4 5 6 7 8 9 ];
      in
      [
        # Applications
        "SUPER, Return, exec, kitty"
        "SUPER, B, exec, librewolf"
        "SUPER, V, exec, firefox"
        "SUPER, E, exec, thunar"

        # Focus Shift
        "SUPER, k, movefocus, u"
        "SUPER, j, movefocus, d"
        "SUPER, l, movefocus, r"
        "SUPER, h, movefocus, l"

        # Window Focus Shifting
        "ALT, Tab, cyclenext, "
        "ALT, Tab, bringactivetotop, "

        # Workspace shifting, more added to end of list.
        "SUPER, mouse_down, workspace, e-1"
        "SUPER, mouse_up, workspace, e+1"
        "CTRL ALT, left,  workspace, e-1"
        "CTRL ALT, right, workspace, e+1"

        # Window to workspace shifting, more at end of list.
        "CTRL SUPER, right, movetoworkspace, +1"
        "CTRL SUPER, left,  movetoworkspace, -1"

        # Move to next empty workspace
        "CTRL ALT, E, workspace, empty"
        "SUPER CTRL, E, movetoworkspace, empty"

        # Misc
        "CTRL ALT, Delete, exit"
        "CTRL SHIFT, Q, killactive"
        "ALT, F, togglefloating"
        "SUPER, F, fullscreen"
        "SUPER, O, fakefullscreen"
        "SUPER, P, pseudo,"
        "SUPER SHIFT, P, togglesplit"
        "SUPER CTRL, P, pin"
        "SUPER, M, fullscreen, 1"
        "SUPER, space, togglefloating"
      ]
      ++ (map (i: "SUPER, ${toString i}, workspace, ${toString i}") num)
      ++ (map (i: "CTRL SUPER, ${toString i}, movetoworkspace, ${toString i}") num);

    binde = [
      # Resize active window
      "SUPER CTRL, k, resizeactive, 0 -20"
      "SUPER CTRL, j, resizeactive, 0 20"
      "SUPER CTRL, l, resizeactive, 20 0"
      "SUPER CTRL, h, resizeactive, -20 0"

      # Move Windows
      "SUPER SHIFT, h, movewindow, l"
      "SUPER SHIFT, l, movewindow, r"
      "SUPER SHIFT, k, movewindow, u"
      "SUPER SHIFT, j, movewindow, d"
      # Audio
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

      # Brightness
      ", XF86KBDBrightnessUp, exec, brightnessctl set 10%+"
      ", XF86KBDBrightnessDown, exec, brightnessctl set 10%-"
    ];

    bindm = [
      # Window move and resize
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    bindl = [
      # Audio
      ", XF86AudioPrev, exec, playerctl --player playerctld previous"
      ", XF86AudioNext, exec, playerctl --player playerctld next"
      ", XF86AudioPlay, exec, playerctl --player playerctld play-pause"

      # Repeated both here and in binde, because one is required for inhibition, and other one is for repetition.
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

      # Repeated both here and in binde, because one is required for inhibition, and other one is for repetition.
      ", XF86KBDBrightnessUp, exec, brightnessctl set 10%+"
      ", XF86KBDBrightnessDown, exec, brightnessctl set 10%-"
    ];
  };
}
