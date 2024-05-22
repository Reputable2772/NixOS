{ config, config', pkgs, lib, ... }:
let
  script = name: extra: extra_pkgs: execer: fake: builtins.toString (
    pkgs.resholve.writeScript name
      {
        interpreter = lib.getExe pkgs.bash;
        inputs = with pkgs; [ coreutils ] ++ extra_pkgs;
        inherit execer fake;
      }
      (lib.optionalString (builtins.stringLength extra > 0) extra)
  );
  gocryptfs = cmd: lib.optionalString (config'.users.${config.home.username}.mounts ? gocryptfs && config'.users.${config.home.username}.mounts.gocryptfs != null)
    ''
      ${lib.pipe
        config'.users.${config.home.username}.mounts.gocryptfs
        (with lib; [
          (attrsets.mapAttrs (n: v: cmd n v))
          attrsets.attrValues
          (strings.concatStringsSep "\n")
        ])
      }
    '';
in
{
  age.secrets."important-files".file = ../../../Config/important-files.age;

  systemd.user.services = {
    podman-login = {
      Service = {
        Type = "forking";
        Restart = "on-failure";
        RestartSec = 5;
        ExecStart = script "login.sh"
          (gocryptfs (n: v: "gocryptfs ${v.source} ${v.mountpoint} ${lib.optionalString (v ? authentication && v.authentication) "-passfile ${config.age.secrets.${n}.path}"}"))
          [ pkgs.gocryptfs ]
          [ "cannot:${lib.getExe' pkgs.gocryptfs "gocryptfs"}" ]
          { };
        ExecStop = script "logout.sh"
          (gocryptfs (n: v: "umount ${v.mountpoint}"))
          [ pkgs.util-linux ]
          [ ]
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

