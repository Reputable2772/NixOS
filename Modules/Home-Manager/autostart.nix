{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.xdg.autostart;

  inherit (lib) strings types;
  inherit (lib.modules) mkIf mkForce mkRenamedOptionModule;
  inherit (lib.options) literalExpression mkOption;
in
{
  options.xdg.autostart = {
    packages = mkOption {
      default = [ ];
      example = literalExpression "[ pkgs.gnome.pomodoro ]";
      type = types.listOf types.package;
      description = lib.mdDoc "Packages that need to be autostarted.";
    };

    # files has been replaced by entries upstream.

    flatpaks = mkOption {
      default = [ ];
      example = ''[ "io.gitlab.news_flash.NewsFlash" ]'';
      type = types.listOf types.str;
      description = "Flatpaks that need to be autostarted.";
    };
  };

  imports = [
    (mkRenamedOptionModule [ "programs" "autostart" "enable" ] [ "xdg" "autostart" "enable" ])
    (mkRenamedOptionModule [ "programs" "autostart" "files" ] [ "xdg" "autostart" "entries" ])
    (mkRenamedOptionModule [ "programs" "autostart" "packages" ] [ "xdg" "autostart" "packages" ])
    (mkRenamedOptionModule [ "programs" "autostart" "flatpaks" ] [ "xdg" "autostart" "flatpaks" ])
  ];

  config = mkIf cfg.enable {
    xdg.autostart.packages = map (
      n:
      "${pkgs.makeDesktopItem {
        name = n;
        exec = "flatpak run ${n}";
        desktopName = n;
        categories = [ "Applications" ];
      }}"
    ) cfg.flatpaks;

    # Overwrite upstream's definition to allow for packages
    # and its desktop files
    xdg.configFile.autostart.source = mkForce (
      pkgs.runCommand "autostart-applications" { } ''
        mkdir $out

        for dir in ${strings.escapeShellArgs cfg.packages}; do
          ln -s $dir/share/applications/*.desktop $out/
        done

        for file in ${strings.escapeShellArgs cfg.entries}; do
          ln -s $file $out/
        done
      ''
    );

    # Upstream does this, but anyway.
    xdg.configFile.autostart.recursive = !cfg.readOnly;
  };
}
