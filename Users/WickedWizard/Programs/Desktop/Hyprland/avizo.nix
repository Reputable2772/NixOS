{
  config,
  pkgs,
  lib,
  ...
}:
let
  volume = "${pkgs.avizo}/bin/volumectl";
  brightness = "${pkgs.avizo}/bin/lightctl";
in
{
  stylix.targets.avizo.enable = config.services.avizo.enable;

  services.avizo.enable =
    config.wayland.windowManager.hyprland.enable && !config.programs.hyprpanel.enable;

  wayland.windowManager.hyprland.settings = {
    bind = [
      {
        _args = [
          "XF86AudioRaiseVolume"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${volume} -d +")'')
          {
            repeating = true;
            locked = true;
          }
        ];
      }
      {
        _args = [
          "XF86AudioLowerVolume"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${volume} -d -")'')
          {
            repeating = true;
            locked = true;
          }
        ];
      }
      {
        _args = [
          "XF86AudioMute"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${volume} -d %")'')
          {
            locked = true;
          }
        ];
      }
      {
        _args = [
          "XF86MonBrightnessUp"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${brightness} -d + 2")'')
          {
            repeating = true;
            locked = true;
          }
        ];
      }
      {
        _args = [
          "XF86MonBrightnessDown"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${brightness} -d - 2")'')
          {
            repeating = true;
            locked = true;
          }
        ];
      }
    ];
  };
}
