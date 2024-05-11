{ pkgs, lib, ... }:
let
  script = name: podman: sleep: builtins.toString (
    pkgs.resholve.writeScript name
      {
        interpreter = "${lib.getExe pkgs.bash}";
        inputs = with pkgs; [ podman-compose coreutils ];
        execer = [
          "cannot:${lib.getExe pkgs.podman-compose}"
        ];
      }
      ''
        ${lib.optionalString sleep "sleep 30"}

        cd $HOME/Documents/Applications/Containers

        for folder in *; do
          echo "In $folder"
          cd $folder
          podman-compose ${podman}
          cd ..
        done
      ''
  );
in
{
  systemd.user.services = {
    podman-login = {
      Service = {
        Type = "forking";
        Restart = "on-failure";
        RestartSec = 5;
        ExecStart = script "login.sh" "up -d" true;
        ExecStop = script "logout.sh" "down" false;
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
