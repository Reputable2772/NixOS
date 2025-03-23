{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = lib.optional (!config.programs.gnome.enable) pkgs.qalculate-qt;

  services.flatpak.packages = lib.optional config.programs.gnome.enable "org.gnome.Calculator";

  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, Equal, exec, flatpak run io.github.Qalculate"
    ", XF86Calculator, exec, flatpak run io.github.Qalculate"
  ];
}
