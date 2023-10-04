{ config, pkgs, ... }: {
  systemd.user.services = {
    podman-login = {
      Service = {
        Type = "forking";
        # RemainAfterExit = true;
        # StandardOutput = "journal";
        Restart = "on-failure";
        RestartSec = 5;
        ExecStart = "/run/current-system/sw/bin/bash /home/wickedwizard/Documents/NixOS/WickedWizard/Services/login.sh";
        ExecStop = "/run/current-system/sw/bin/bash /home/wickedwizard/Documents/NixOS/WickedWizard/Services/logout.sh";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Unit = {
        Description = "Podman Services";
        After = [ "graphical-session-pre.target" ];
      };
    };
  };
}
