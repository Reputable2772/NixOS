{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.programs.autostart;
in
{
  options.programs.autostart = {
    enable = mkOption {
      type = types.bool;
      default = !config.programs.gnome.enable;
      description = ''
        Enable Autostart Home-Manager Module
      '';
    };

    autostartPackages = mkOption {
      default = [ ];
      example = literalExpression "[ pkgs.gnome.pomodoro ]";
      type = types.listOf types.package;
      description = lib.mdDoc "Packages that need to be autostarted.";
    };

    autostartFiles = mkOption {
      default = [ ];
      example = literalExpression "\$\{pkgs.gnome.pomodoro\}/share/applications/org.gnome.Pomodoro.desktop";
      type = types.listOf types.path;
      description = lib.mdDoc "Path to the desktop file that needs to be autostarted";
    };
  };

  config = {
    xdg.configFile."autostart".source = pkgs.runCommand "" { } ''
      mkdir $out

      for dir in ${strings.escapeShellArgs cfg.autostartPackages}; do
        ln -s $dir/share/applications/*.desktop $out/
      done

      for file in ${strings.escapeShellArgs cfg.autostartFiles}; do
        ln -s $file $out/
      done
    '';
  };
}
