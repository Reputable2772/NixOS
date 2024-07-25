{ config', pkgs, lib, ... }: {
  programs.backup = {
    inherit (config'.backup) repository;
    paths = {
      inherit (config'.backup.paths) include exclude;
    };
    enable = true;
    preBackupScript = ''
      # Config for ludusavi should be set by ludusavi itself.
      ${lib.getExe pkgs.ludusavi} backup --force
    '';
  };
}
