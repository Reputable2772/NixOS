{ config, pkgs, ... }:
let
  safeeyes =
    if config.wayland.windowManager.hyprland.enable then
      pkgs.symlinkJoin
        {
          inherit (pkgs.safeeyes) name meta;

          paths = [ pkgs.safeeyes ];
          nativeBuildInputs = [ pkgs.makeWrapper ];

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

  programs.autostart.packages = [ safeeyes ];
}
