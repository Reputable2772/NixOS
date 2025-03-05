{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = lib.optional config.wayland.windowManager.hyprland.enable pkgs.wlogout;

  programs.waybar.settings.mainBar."custom/logout" =
    lib.optionalAttrs config.wayland.windowManager.hyprland.enable
      {
        format = "<span color='#8aadf4'> 󰐥 </span>";
        on-click = lib.getExe pkgs.wlogout;
        tooltip = false;
      };
}
