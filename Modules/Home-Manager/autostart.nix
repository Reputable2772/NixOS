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

    flatpaks = mkOption {
      default = [ ];
      example = ''[ "io.gitlab.news_flash.NewsFlash" ]'';
      type = types.listOf types.str;
      description = "Flatpaks that need to be autostarted.";
    };
  };

  config = mkIf cfg.enable {
    programs.autostart.packages = lists.map (
      n:
      pkgs.makeDesktopItem {
        name = n;
        exec = "flatpak run ${n}";
        desktopName = n;
        categories = [ "Applications" ];
      }
    ) cfg.flatpaks;

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
