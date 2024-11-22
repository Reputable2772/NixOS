{ config, sources, ... }:
{
  services.hyprpaper = {
    inherit (config.wayland.windowManager.hyprland) enable;

    settings = rec {
      preload = sources.hyprland_background.src.outPath;
      wallpaper = ", ${preload}";
      unload = preload;
    };
  };
}
