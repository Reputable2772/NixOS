{ sources, lib', ... }:
{
  programs.foot = {
    enable = true;
    settings = { } // lib'.iniToNix "${sources.foot_catppuccin.src}/themes/catppuccin-mocha.ini";
  };

  dconf.settings."org/cinnamon/desktop/applications/terminal".exec = "foot";

  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, Return, exec, foot"
  ];
}
