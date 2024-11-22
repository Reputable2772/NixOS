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

  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "fullscreen,initialClass:^(Safeeyes)$"
    "stayfocused,initialClass:^(Safeeyes)$"
    "focusonactivate,initialClass:^(Safeeyes)$"
  ];

  # programs.autostart.packages = [ safeeyes ];
}
