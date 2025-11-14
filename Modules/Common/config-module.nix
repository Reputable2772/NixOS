{
  lib,
  name ? "",
  config ? { },
}:
let
  inherit (lib) types;
  inherit (lib.options) mkEnableOption mkOption;

  mkListOption =
    type:
    mkOption {
      default = [ ];
      description = "for ${name}";
      type = types.listOf type;
    };
in
{
  options.${name} = {
    enable = mkEnableOption name // {
      default = true;
    };

    firewall = mkOption {
      default = { };
      description = "Firewall config";
      type = types.submodule {
        options = {
          allowedTCPPortRanges = mkListOption types.attrs;
          allowedUDPPortRanges = mkListOption types.attrs;
          allowedTCPPorts = mkListOption types.int;
          allowedUDPPorts = mkListOption types.int;
        };
      };
    };

    nixpkgs.config.permittedInsecurePackages = mkOption {
      description = "Permitted Insecure Packages";
      default = [ ];
      type = types.listOf types.str;
    };

    nixpkgs.config.allowUnfreePredicate = mkOption {
      description = "Allow Unfree Predicate Packages";
      default = [ ];
      type = types.listOf types.str;
    };

    environment.etc = mkOption {
      description = "Symlinking Files to environment.etc";
      default = { };
      type = types.attrs;
    };
  };

  inherit config;
}
