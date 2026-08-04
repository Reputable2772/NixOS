{
  config,
  pkgs,
  lib,
  ...
}:
let
  toml = pkgs.formats.toml { };
  inherit (lib.options) mkEnableOption mkOption;
in
{
  options.programs.nvfetcher = {
    enable = mkEnableOption "declaratively writing nvfetcher.toml" // {
      default = config.programs.nvfetcher.config != { };
    };
    config = mkOption {
      description = "Config for nvfetcher.toml";
      type = toml.type;
      default = { };
    };
  };
}
