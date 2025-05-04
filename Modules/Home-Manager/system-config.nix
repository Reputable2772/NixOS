{ lib, ... }:
let
  inherit (lib) types;
  inherit (lib.options) mkEnableOption mkOption;

  mkListOption =
    type:
    mkOption {
      default = [ ];
      description = "for system-config";
      type = types.listOf type;
    };
in
{
  options.system-config = {
    enable = mkEnableOption "propagating specific config to the system." // {
      default = true;
    };

    firewall = mkOption {
      default = { };
      description = "Firewall config to be propagated.";
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
  };
}
