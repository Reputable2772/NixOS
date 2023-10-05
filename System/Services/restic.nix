{ config, pkgs, ... }: {
  services.restic.backups = {
    localBackup = {
      exclude = [
        "${config.users.users.wickedwizard.home}/Documents/Photos/*"
      ];
      paths = [
        "${config.users.users.wickedwizard.home}/Documents/"
      ];
      repository = "${config.users.users.wickedwizard.home}/Backups";
      passwordFile = "${config.users.users.wickedwizard.home}/Documents/NixOS/Sensitive/Backup-Key.txt";
      initialize = true;
      user = "wickedwizard";
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };
    };
  };
}
