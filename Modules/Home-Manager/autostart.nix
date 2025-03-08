{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.autostart;
in
{
  # TODO: Add option for flatpaks.
  options.programs.autostart = {
    enable = mkOption {
      type = types.bool;
      default = !config.programs.gnome.enable;
      description = ''
        Enable Autostart Home-Manager Module
      '';
    };

    packages = mkOption {
      default = [ ];
      example = literalExpression "[ pkgs.gnome.pomodoro ]";
      type = types.listOf types.package;
      description = lib.mdDoc "Packages that need to be autostarted.";
    };

    files = mkOption {
      default = [ ];
      example = literalExpression "\$\{pkgs.gnome.pomodoro\}/share/applications/org.gnome.Pomodoro.desktop";
      type = types.listOf types.path;
      description = lib.mdDoc "Path to the desktop file that needs to be autostarted";
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile."autostart".source = pkgs.runCommand "" { } ''
      mkdir $out

      for dir in ${strings.escapeShellArgs cfg.packages}; do
        ln -s $dir/share/applications/*.desktop $out/
      done

      for file in ${strings.escapeShellArgs cfg.files}; do
        ln -s $file $out/
      done
    '';
    xdg.configFile."autostart".recursive = true;
  };
}
