{ config, ... }:
{
  services.hyprpaper.enable = config.wayland.windowManager.hyprland.enable;
  stylix.targets.hyprland.hyprpaper.enable = config.wayland.windowManager.hyprland.enable;
}
