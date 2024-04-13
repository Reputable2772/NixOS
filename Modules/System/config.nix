{ config, lib, ... }:
with lib;
let
  cfg = config.programs.config_dir;
in
{
  options.programs.config_dir = {
    config_dir = mkOption {
      example = literalExpression "$HOME/Documents/Config";
      type = types.path;
      description = lib.mdDoc "Directory where all undeclarative config is stored.";
    };
    browser_dir = mkOption {
      default = "${cfg.config_dir}/Browsers";
      example = literalExpression "\$\{config.users.users.name.home\}/Documents";
      type = types.path;
      description = lib.mdDoc "Directory where browsers configuration data is stored.";
    };
    self_dir = mkOption {
      default = "${cfg.config_dir}/NixOS";
      example = literalExpression "\$\{config.users.users.name.home\}/NixOS";
      type = types.path;
      description = lib.mdDoc "Directory where your system flake is stored.";
    };
  };

  # config = { };
}
