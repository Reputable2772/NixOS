/**
  Stub module. Real things occur in
  System/Common/backup.nix
 */
{ lib, ... }:
let
  inherit (lib) types;
  inherit (lib.options) mkEnableOption mkOption;
in
{
  options.programs.backup = {
    enable = mkEnableOption "backups";

    repository = mkOption {
      type = types.str;
      default = "";
      description = ''
        Repository location for backups.
      '';
    };

    preBackupScript = mkOption {
      type = types.str;
      default = "";
      description = ''
        Bash script to run before backup.
      '';
    };

    paths = mkOption {
      description = "Path details";
      type = types.submodule {
        options = {
          include = mkOption {
            default = [ ];
            type = types.listOf types.str;
            description = "Paths to include for backup.";
          };
          exclude = mkOption {
            default = [ ];
            type = types.listOf types.str;
            description = "Paths to include for backup.";
          };
        };
      };
    };
  };
}
