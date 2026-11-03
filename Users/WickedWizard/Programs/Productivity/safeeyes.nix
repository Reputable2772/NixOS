{ config, pkgs, ... }:
let
  safeeyes =
    if config.wayland.windowManager.hyprland.enable then
      pkgs.symlinkJoin {
        inherit (pkgs.safeeyes) name meta;

        paths = [ pkgs.safeeyes ];
        nativeBuildInputs = [ pkgs.makeWrapper ];

        /**
          This ends up double wrapping the package,
          since makeWrapper is used in the original package
          also.
        */
        postBuild = ''
          wrapProgram $out/bin/safeeyes \
            --prefix XDG_CURRENT_DESKTOP : sway
        '';
      }
    else
      pkgs.safeeyes;
in
{
  home.packages = [ safeeyes ];

  wayland.windowManager.hyprland.settings.window_rule = [
    {
      match = {
        initial_class = "^(Safeeyes)$";
      };
      fullscreen = true;
      stay_focused = true;
      focus_on_activate = true;
    }
  ];

  xdg.autostart.packages = [ safeeyes ];
}
