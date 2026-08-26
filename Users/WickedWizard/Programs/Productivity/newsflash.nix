{
  services.flatpak.packages = [ "io.gitlab.news_flash.NewsFlash" ];

  wayland.windowManager.hyprland.settings.windowrule = [
    "match:initial_title (Newsflash), workspace 2"
  ];

  xdg.autostart.flatpaks = [ "io.gitlab.news_flash.NewsFlash" ];
}
