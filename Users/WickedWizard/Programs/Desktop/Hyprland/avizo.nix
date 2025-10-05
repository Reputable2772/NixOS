{ config, pkgs, ... }:
let
  volume = "${pkgs.avizo}/bin/volumectl";
  brightness = "${pkgs.avizo}/bin/lightctl";
in
{
  stylix.targets.avizo.enable = config.services.avizo.enable;

  services.avizo.enable =
    config.wayland.windowManager.hyprland.enable && !config.programs.hyprpanel.enable;

  wayland.windowManager.hyprland.settings = {
    # This part is for the keybinds to repeat when holding.
    binde = [
      ", XF86AudioRaiseVolume, exec, ${volume} -d +"
      ", XF86AudioLowerVolume, exec, ${volume} -d -"

      ", XF86MonBrightnessUp, exec, ${brightness} -d + 2"
      ", XF86MonBrightnessDown, exec, ${brightness} -d - 2"
    ];

    # This is for the keybinds to work from the lockscreen.
    bindl = [
      ", XF86AudioRaiseVolume, exec, ${volume} -d +"
      ", XF86AudioLowerVolume, exec, ${volume} -d -"
      ", XF86AudioMute, exec, ${volume} -d %"

      ", XF86MonBrightnessUp, exec, ${brightness} -d + 2"
      ", XF86MonBrightnessDown, exec, ${brightness} -d - 2"
    ];
  };
}
