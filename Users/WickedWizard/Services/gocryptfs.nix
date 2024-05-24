{ config, config', pkgs, lib, ... }:
let
  script = name: script: extra_pkgs: execer: fake: builtins.toString (
    pkgs.resholve.writeScript name
      {
        interpreter = lib.getExe pkgs.bash;
        inputs = with pkgs; [ coreutils ] ++ extra_pkgs;
        inherit execer fake;
      }
      script
  );
  gocryptfs = cmd: lib.optionalString (config'.users.${config.home.username}.mounts ? gocryptfs && config'.users.${config.home.username}.mounts.gocryptfs != null)
    ''
      ${lib.pipe
        config'.users.${config.home.username}.mounts.gocryptfs
        (with lib; [
          (attrsets.mapAttrs cmd)
          attrsets.attrValues
          (strings.concatStringsSep "\n")
        ])
      }
    '';
in
{
  age.secrets."important-files".file = ../../../Config/important-files.age;

  systemd.user.services = {
    gocryptfs = {
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
          (gocryptfs (n: v: "fusermount -u ${v.mountpoint}"))
          [ pkgs.fuse ]
          [ ]
          { external = [ "fusermount" ]; };
        # Force gocryptfs and others to use the fusermount wrapper in /run/wrappers/bin, otherwise permissions error occurs.
        Environment = [ "PATH=/run/wrappers/bin" ];
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}

