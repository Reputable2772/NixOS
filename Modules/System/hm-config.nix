{ config, lib, ... }:
let
  inherit (lib.attrsets) attrValues mapAttrs getAttrFromPath;
  inherit (lib.lists) flatten;
  inherit (lib.modules) mkIf;

  cfg = config.hm-config;

  # Merge all options from all users for a given option into a single list
  mkMergeListOptions =
    path:
    flatten (
      attrValues (
        mapAttrs (n: v: getAttrFromPath ([ "system-config" ] ++ path) v) config.home-manager.users
      )
    );
in
import ../config-module.nix {
  inherit lib;
  name = "hm-config";
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

      nixpkgs.config.allowUnfreePredicate = mkMergeListOptions [
        "nixpkgs"
        "config"
        "allowUnfreePredicate"
      ];
    };
  };
}
