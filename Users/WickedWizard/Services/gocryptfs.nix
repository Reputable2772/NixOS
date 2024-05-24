{ config, config', pkgs, lib, ... }:
let
  inherit (lib.attrsets) mapAttrs attrValues filterAttrs concatMapAttrs;
  inherit (lib.strings) concatStringsSep;
  inherit (lib.trivial) pipe;
  script = name: script: extra_pkgs: execer: fake: builtins.toString (
    pkgs.resholve.writeScript name
      {
        interpreter = lib.getExe pkgs.bash;
        inputs = with pkgs; [ coreutils ] ++ extra_pkgs;
        inherit execer fake;
      }
      script
  );
  gocryptfs = _pipe: lib.mkIf
    (config'.users.${config.home.username}.mounts ? gocryptfs && config'.users.${config.home.username}.mounts.gocryptfs != null)
    (pipe config'.users.${config.home.username}.mounts.gocryptfs _pipe);
in
{
  age.secrets = gocryptfs [
    (filterAttrs (n: v: v ? authentication && v.authentication))
    (concatMapAttrs (n: v: {
      ${n}.file = ./. + "../../../../Config/${n}.age";
    }))
  ];

  systemd.user.services.gocryptfs =
    let
      gocryptfs_map = cmd:
        (gocryptfs [
          (mapAttrs cmd)
          attrValues
          (concatStringsSep "\n")
        ]).content;
    in
    {
      Service = {
        Type = "forking";
        Restart = "on-failure";
        RestartSec = 5;
        ExecStart = script "login.sh"
          (gocryptfs_map (n: v: "gocryptfs ${v.source} ${v.mountpoint} ${lib.optionalString (v ? authentication && v.authentication) "-passfile ${config.age.secrets.${n}.path}"}"))
          [ pkgs.gocryptfs ]
          [ "cannot:${lib.getExe' pkgs.gocryptfs "gocryptfs"}" ]
          { };
        ExecStop = script "logout.sh"
          (gocryptfs_map (n: v: "fusermount -u ${v.mountpoint}"))
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
}

