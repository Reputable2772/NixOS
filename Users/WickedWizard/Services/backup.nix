{ config, pkgs, ... }: {
  systemd.user.services = {
    backup = {
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.lib.getExe' pkgs.restic "restic"} -r /home/wickedwizard/Backups --password-file /home/wickedwizard/Documents/Config/Backup-Key.txt backup /home/wickedwizard/Documents/; ${pkgs.lib.getExe' pkgs.rclone "rclone"} --verbose sync /home/wickedwizard/Backups backup:Backups";
      };
      Unit = {
        Description = "Restic Backup";
        After = [ "network-online.target" ];
        Wants = [ "network-online.target" ];
      };
    };
  };
}
