{
  wayland.windowManager.hyprland.settings = {
    window_rule = [
      # Fullscreen should inhibit idle
      {
        match = {
          fullscreen = true;
        };
        idle_inhibit = "fullscreen";
      }

      # Picture-in-Picture for any windows tagged pip
      {
        match = {
          tag = "pip";
        };
        float = true;
        pin = true;
        keep_aspect_ratio = true;
        decorate = false;

        size = "480 270";
        min_size = "240 135";
        max_size = "960 540";
        move = "100%-490 100%-280";
      }

      # Make pop-up file dialogs floating, centred, and pinned
      {
        match = {
          title = "(Progress|Save File|Save As)";
        };
        tag = "+dialog";
      }
      {
        match = {
          class = "xdg-desktop-portal-gtk";
        };
        tag = "+dialog";
      }

      {
        match = {
          tag = "dialog";
        };
        float = true;
        center = true;
        pin = true;
        decorate = false;
      }

      {
        match = {
          initial_class = "chromium-browser";
        };
        focus_on_activate = false;
        no_initial_focus = true;
      }
    ];
  };
}
