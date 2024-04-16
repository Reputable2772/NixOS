{ lib, osConfig, ... }: {
  imports = [
    ./Gnome
    ./Theming
  ]
  ++ lib.optional osConfig.programs.hyprland.enable ./Hyprland;
}
