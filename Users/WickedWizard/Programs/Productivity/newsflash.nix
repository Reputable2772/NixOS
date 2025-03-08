{ pkgs, ... }:
{
  # TODO: Convert to flatpak.
  home.packages = with pkgs; [ newsflash ];

  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "workspace 2, initialTitle:(Newsflash)"
  ];

  programs.autostart.packages = with pkgs; [ newsflash ];
}
