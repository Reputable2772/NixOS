{ config, config', pkgs, lib, ... }:
let
  script = name: podman: sleep: extra: extra_pkgs: extra_rules: builtins.toString (
    pkgs.resholve.writeScript name
      {
        interpreter = "${lib.getExe pkgs.bash}";
        inputs = with pkgs; [ podman-compose coreutils ] ++ lib.optionals (builtins.length extra_pkgs > 0) extra_pkgs;
        execer = [
          "cannot:${lib.getExe pkgs.podman-compose}"
        ] ++ lib.optionals (builtins.length extra_rules > 0) extra_rules;
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
        ExecStart = script "login.sh" "up -d" true ''
          export BW_SESSION=$(bw unlock $(ssh-askpass-fullscreen) --raw)
          export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent

          for folder in $(find ${config'.users.${config.home.username}.config.dir.config}/SSH/ -type f ! -name "*.*"); do
            key=$(basename $folder)
            pass=$(bw get item $key | jq ".login.password" | tr -d '"')
            expect -c "spawn ssh-add $folder" -c "expect \"Enter passphrase\"" -c "send \"$pass\r\"" -c "expect eof"
          done
        ''
          (with pkgs; [
            bitwarden-cli
            ssh-askpass-fullscreen
            jq
            expect
            findutils
          ]) [
          "cannot:${lib.getExe pkgs.expect}"
          "cannot:${lib.getExe pkgs.bitwarden-cli}"
        ];
        ExecStop = script "logout.sh" "down" false ''
          bw lock
        '' [ pkgs.bitwarden-cli ] [ "cannot:${lib.getExe pkgs.bitwarden-cli}" ];
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
