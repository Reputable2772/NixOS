{ config, lib, ... }:
with lib;
let
  cfg = config.programs.gnome;
in
{
  options.program.gnome = {
    enable = mkOption {
      type = types.bool;
      default = config.programs.gnome.enable;
      description = ''
        Enable Gnome Desktop Home-Manager Module
      '';
    };

    extensions = mkOption {
      default = [ ];
      example = literalExpression "[ pkgs.gnome.vitals ]";
      type = types.listOf types.package;
      description = lib.mdDoc "Which extensions gnome should install";
    };

    themeing = mkOption {
      type = types.listOf (types.submodule {
        options = {
          # TODO: Add theming options here.
        };
      });
    };
  };

  config = {
    home.packages = mkIf cfg.enable cfg.extensions;
  };
}
