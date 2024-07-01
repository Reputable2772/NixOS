{ config, pkgs, ... }: {
  programs.thunar = {
    inherit (config.programs.hyprland) enable;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
}
