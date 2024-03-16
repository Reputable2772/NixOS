{
  systemd.user.services = {
    backup = {
      Service = {
        Type = "oneshot";
        ExecStart = "/run/current-system/sw/bin/bash /home/wickedwizard/Documents/NixOS/Users/WickedWizard/Services/backup.sh";
      };
      Unit = {
        Description = "Restic Backup";
        After = [ "network-online.target" ];
        Wants = [ "network-online.target" ];
      };
    };
  };
}
