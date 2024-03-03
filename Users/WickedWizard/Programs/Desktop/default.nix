{ lib, osConfig, ... }: {
  imports = [
    ./Theming
  ]
  ++ lib.optional (osConfig.programs.hyprland.enable) ./Hyprland
  ++ lib.optional (osConfig.services.xserver.desktopManager.gnome.enable) ./Gnome;
}
