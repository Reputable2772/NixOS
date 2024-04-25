{ pkgs, lib, ... }:
let
  script = name: podman: sleep: extra: extra_pkgs: builtins.toString (
    pkgs.resholve.writeScriptBin name
      {
        interpreter = "${lib.getExe pkgs.bash}";
        inputs = with pkgs; [ podman-compose coreutils ] ++ lib.optionals (builtins.length extra_pkgs > 0) extra_pkgs;
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

        ${lib.optionalString (builtins.stringLength extra > 0) extra}
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
        ExecStart = script "login.sh" "up -d" true "" [ ];
        ExecStop = script "logout.sh" "down" false "" [ ];
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
