{ pkgs, lib', ... }:
{
  programs.foot = {
    enable = true;
    settings = { } // lib'.iniToNix pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/foot/main/themes/catppuccin-mocha.ini";
      hash = "";
    };
  };

  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, Return, exec, foot"
  ];
}
