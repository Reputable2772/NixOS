{ config, lib, ... }:
let
  inherit (lib) types;
  inherit (lib.attrsets) attrValues mapAttrs getAttrFromPath;
  inherit (lib.lists) flatten;
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkOption;

  cfg = config.hm-config;

  mkListOption =
    type:
    mkOption {
      default = [ ];
      description = "system-config derived from hm-config";
      type = types.listOf type;
    };

  mkMergeListOptions =
    path:
    flatten (
      attrValues (
        mapAttrs (n: v: getAttrFromPath ([ "system-config" ] ++ path) v) config.home-manager.users
      )
    );
in
{
  options.hm-config = {
    enable = mkEnableOption "allowing the propagated config." // {
      default = true;
    };

    firewall = mkOption {
      description = "Firewall config";
      default = { };
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

  config = mkIf cfg.enable {
    hm-config = {
      firewall = {
        allowedTCPPortRanges = mkMergeListOptions [
          "firewall"
          "allowedTCPPortRanges"
        ];
        allowedUDPPortRanges = mkMergeListOptions [
          "firewall"
          "allowedUDPPortRanges"
        ];
        allowedTCPPorts = mkMergeListOptions [
          "firewall"
          "allowedTCPPorts"
        ];
        allowedUDPPorts = mkMergeListOptions [
          "firewall"
          "allowedUDPPorts"
        ];
      };

      nixpkgs.config.permittedInsecurePackages = mkMergeListOptions [
        "nixpkgs"
        "config"
        "permittedInsecurePackages"
      ];
    };
  };
}
