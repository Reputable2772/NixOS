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
    {
      _args = [
        "SUPER + Equal"
        (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("flatpak run io.github.Qalculate")'')
      ];
    }
    {
      _args = [
        "XF86Calculator"
        (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("flatpak run io.github.Qalculate")'')
      ];
    }
  ];
}
