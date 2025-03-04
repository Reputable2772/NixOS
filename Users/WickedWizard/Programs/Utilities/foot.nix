{ config, ... }:
{
  programs.foot.enable = true;
  stylix.targets.foot.enable = config.programs.foot.enable;

  dconf.settings."org/cinnamon/desktop/applications/terminal".exec = "foot";

  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, Return, exec, foot"
  ];
}
