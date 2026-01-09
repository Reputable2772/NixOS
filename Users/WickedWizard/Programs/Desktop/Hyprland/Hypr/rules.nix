{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # Fullscreen should inhibit idle
      "match:fullscreen true, idle_inhibit fullscreen"

      # Picture-in-Picture for any windows tagged pip
      "match:tag pip, float on"
      "match:tag pip, pin on"
      "match:tag pip, keep_aspect_ratio on"
      "match:tag pip, decorate off"
      # "match:tag pip, plugin:hyprbars:nobar"

      "match:tag pip, size 480 270"
      "match:tag pip, min_size 240 135"
      "match:tag pip, max_size 960 540"
      "match:tag pip, move 100%-490 100%-280"

      # Make pop-up file dialogs floating, centred, and pinned
      "match:title (Progress|Save File|Save As), tag +dialog"
      "match:class xdg-desktop-portal-gtk, tag +dialog"

      "match:tag dialog, float on"
      "match:tag dialog, center on"
      "match:tag dialog, pin on"
      "match:tag dialog, decorate off"
    ];
  };
}
