{
  config',
  config,
  lib,
  ...
}:
let
  cfg = config.services.restic;

  inherit (lib) types;
  inherit (lib.options) mkOption;
in
{
  options.services.restic = {
    preBackupScript = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Commands to run before backup.";
    };
  };

  config = {
    age.secrets."${config.home.username}-backup".file = ../../../../Config/wickedwizard-backup.age;

    services.restic = {
      enable = true;
      backups.${config.home.username} = {
        inherit (config'.backup) repository;
        paths = config'.backup.paths.include;
        inherit (config'.backup.paths) exclude;

        initialize = true;
        backupPrepareCommand = lib.concatStringsSep "\n" cfg.preBackupScript;
        passwordFile =
          lib.replaceStrings [ "$\{XDG_RUNTIME_DIR}" ] [ "%t" ]
            config.age.secrets."${config.home.username}-backup".path;
        timerConfig = {
          OnCalendar = "*-*-* 21:00:00";
          Persistent = true;
        };
        inhibitsSleep = true;
        extraBackupArgs = [ "--compression max" ];
      };
    };
  };
}
