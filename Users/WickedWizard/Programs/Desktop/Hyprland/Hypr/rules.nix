{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      # Fullscreen should inhibit idle
      "idleinhibit fullscreen, class:^(*)$"
      "idleinhibit fullscreen, title:^(*)$"
      "idleinhibit fullscreen, fullscreen:1"

      # Picture-in-Picture for any windows tagged pip
      "float, tag:pip"
      "pin, tag:pip"
      "keepaspectratio, tag:pip"
      "noborder, tag:pip"
      "plugin:hyprbars:nobar, tag:pip"
      "size 480 270, tag:pip"
      "minsize 240 135, tag:pip"
      "maxsize 960 540, tag:pip"
      "move 100%-490 100%-280, tag:pip"

      # make pop-up file dialogs floating, centred, and pinned
      "tag +dialog, title:(Progress|Save File|Save As)"
      # "tag +dialog, title:(Open|Progress|Save File|Save As)"
      "tag +dialog, class:(xdg-desktop-portal-gtk)"
      "float, tag:dialog"
      "center, tag:dialog"
      "pin, tag:dialog"
      "noborder, tag:dialog"
    ];
  };
}
