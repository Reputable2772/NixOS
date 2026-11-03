{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.foot.enable = true;
  stylix.targets.foot.enable = config.programs.foot.enable;

  dconf.settings."org/cinnamon/desktop/applications/terminal".exec = "foot";

  wayland.windowManager.hyprland.settings.bind = [
    {
      _args = [
        "SUPER + Return"
        (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.foot}/bin/foot")'')
      ];
    }
  ];
}
