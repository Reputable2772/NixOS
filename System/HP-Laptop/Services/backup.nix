{ config, lib, ... }:
let
  filtered = lib.filterAttrs (n: v: v.programs.backup.enable) config.home-manager.users;
in
{
  age.secrets = lib.mapAttrs' (
    n: v: lib.nameValuePair "${n}-backup" { file = ./. + "../../../../Config/${n}-backup.age"; }
  ) filtered;

  services.restic.backups = lib.mapAttrs (n: v: {
    inherit (v.programs.backup) repository;
    initialize = true;
    backupCleanupCommand = "chown -R ${n}:${config.users.users.${n}.group} ${v.programs.backup.repository}/*";
    backupPrepareCommand = v.programs.backup.preBackupScript;
    paths = v.programs.backup.paths.include;
    exclude = v.programs.backup.paths.exclude;
    passwordFile = config.age.secrets."${n}-backup".path;
    timerConfig = null;
    inhibitsSleep = true;
    extraBackupArgs = [ "--compression max" ];
  }) filtered;
}
