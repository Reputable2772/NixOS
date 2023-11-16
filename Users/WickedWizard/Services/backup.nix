{ config, pkgs, ... }: {
  systemd.user.services = {
    backup = {
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.lib.getExe' pkgs.restic "restic"} -r ${config.home.homeDirectory}/Backups --password-file ${config.home.homeDirectory}/Documents/Config/Backup-Key.txt backup ${config.home.homeDirectory}/Documents/; ${pkgs.lib.getExe' pkgs.rclone "rclone"} --verbose sync ${config.home.homeDirectory}/Backups backup:Backups";
      };
      Unit = {
        Description = "Restic Backup";
        After = [ "network-online.target" ];
        Wants = [ "network-online.target" ];
      };
    };
  };
}
