{ config, config', pkgs, lib, ... }:
let
  script = name: podman: sleep: extra: extra_pkgs: extra_rules: fake: builtins.toString (
    pkgs.resholve.writeScript name
      {
        interpreter = "${lib.getExe pkgs.bash}";
        inputs = with pkgs; [ podman-compose coreutils ] ++ extra_pkgs;
        execer = [
          "cannot:${lib.getExe pkgs.podman-compose}"
        ] ++ extra_rules;
        inherit fake;
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
  age.secrets."important-files".file = ../../../Config/important-files.age;

  systemd.user.services = {
    podman-login = {
      Service = {
        Type = "forking";
        Restart = "on-failure";
        RestartSec = 5;
        ExecStart = script "login.sh" "up -d" true
          (lib.optionalString (config'.users.${config.home.username}.mounts ? gocryptfs && config'.users.${config.home.username}.mounts.gocryptfs != null) ''
            ${lib.pipe
              config'.users.${config.home.username}.mounts.gocryptfs
              (with lib; [
                (attrsets.mapAttrs (n: v: "gocryptfs ${v.source} ${v.mountpoint} ${optionalString (v ? authentication && v.authentication) "-passfile ${config.age.secrets.${n}.path}"}"))
                attrsets.attrValues
                (strings.concatStringsSep "\n")
              ])
            }
          '') [ pkgs.gocryptfs ] [ "cannot:${lib.getExe' pkgs.gocryptfs "gocryptfs"}" ]
          { };
        ExecStop = script "logout.sh" "down" false
          (lib.optionalString (config'.users.${config.home.username}.mounts ? gocryptfs && config'.users.${config.home.username}.mounts.gocryptfs != null) ''
            ${lib.pipe
              config'.users.${config.home.username}.mounts.gocryptfs
              (with lib; [
                (attrsets.mapAttrs (n: v: "umount ${v.mountpoint}"))
                attrsets.attrValues
                (strings.concatStringsSep "\n")
              ])
            }
          '') [ pkgs.util-linux ] [ ]
          { external = [ "umount" ]; };
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

