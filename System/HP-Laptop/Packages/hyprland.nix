{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # Been causing issues with multiple HM services, including but not limited to
    # xdg-desktop-portal*, flatpak-managed-install, etc.
    withUWSM = false;
  };

  environment.systemPackages =
    lib.optional (config.programs.hyprland.enable && config.programs.hyprland.withUWSM)
      (
        pkgs.writeScriptBin "hyprland-start" ''
          if ${lib.getExe config.programs.uwsm.package} check may-start; then
            exec ${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop
          fi
        ''
      );
}
