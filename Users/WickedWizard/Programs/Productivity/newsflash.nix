{
  services.flatpak.packages = [ "io.gitlab.news_flash.NewsFlash" ];

  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "workspace 2, initialTitle:(Newsflash)"
  ];

  programs.autostart.flatpaks = [ "io.gitlab.news_flash.NewsFlash" ];
}
