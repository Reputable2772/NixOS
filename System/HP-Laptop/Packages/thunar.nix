{ config, pkgs, ... }: {
  programs.thunar = {
    enable = config.programs.hyprland.enable;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  programs.xfconf.enable = config.programs.hyprland.enable;
  services.gvfs.enable = config.programs.hyprland.enable;
  services.tumbler.enable = config.programs.hyprland.enable;
}
