{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      # Fullscreen should inhibit idle
      "idleinhibit fullscreen, class:^(*)$"
      "idleinhibit fullscreen, title:^(*)$"
      "idleinhibit fullscreen, fullscreen:1"
    ];
  };
}
