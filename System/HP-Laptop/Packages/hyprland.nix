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
    withUWSM = true;
  };

  environment.systemPackages = [
    (pkgs.writeScriptBin "hyprland-start" ''
      if ${lib.getExe config.programs.uwsm.package} check may-start; then
        exec ${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop
      fi
    '')
  ];
}
