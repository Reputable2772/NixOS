{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = lib.optional (
    config.wayland.windowManager.hyprland.enable && !config.programs.hyprpanel.enable
  ) pkgs.wlogout;

  programs.waybar.settings.mainBar."custom/logout" = {
    format = "<span color='#8aadf4'> 󰐥 </span>";
    on-click = lib.getExe pkgs.wlogout;
    tooltip = false;
  };
}
