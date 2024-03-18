{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.programs.gnome;
in
{
  options.programs.gnome = {
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

    gnomeOnlyPackages = mkOption {
      default = [ ];
      example = literalExpression "[ pkgs.gnome.gnome-text-editor ]";
      type = types.listOf types.package;
      description = lib.mdDoc "Apps that you require only if Gnome is installed";
    };
  };

  config = {
    home.packages = mkIf cfg.enable (cfg.extensions ++ cfg.gnomeOnlyPackages);

    # Fixes https://github.com/NixOS/nixpkgs/issues/53631.
    home.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      gst-libav
    ]);
  };
}
