{
  config,
  config',
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.attrsets)
    filterAttrs
    mapAttrs'
    mapAttrsToList
    nameValuePair
    ;
  inherit (lib.strings) concatStringsSep;
  inherit (lib.trivial) pipe;
  script =
    name: script: extra_pkgs: execer: fake:
    (pkgs.resholve.writeScript name {
      interpreter = lib.getExe pkgs.bash;
      inputs = with pkgs; [ coreutils ] ++ extra_pkgs;
      inherit execer fake;
    } script).outPath;
  validMounts =
    _pipe:
    lib.mkIf (config'.mounts ? gocryptfs && config'.mounts.gocryptfs != null) (
      pipe config'.mounts.gocryptfs _pipe
    );
  map_cmd =
    cmd:
    (validMounts [
      (mapAttrsToList cmd)
      (concatStringsSep "\n")
    ]).content;
in
{
  age.secrets = validMounts [
    (filterAttrs (n: v: v ? authentication && v.authentication))
    (mapAttrs' (n: v: nameValuePair n { file = ./. + "../../../../Config/${n}.age"; }))
  ];

  systemd.user.services.gocryptfs = {
    Service = {
      Type = "forking";
      Restart = "on-failure";
      RestartSec = 5;
      ExecStartPre =
        script "gocryptfs-premount.sh" (map_cmd (n: v: "mkdir -p ${v.mountpoint}")) [ ] [ ]
          { };

      ExecStart = script "gocryptfs-mount.sh" (map_cmd (
        n: v:
        "gocryptfs ${v.source} ${v.mountpoint} ${
          lib.optionalString (
            v ? authentication && v.authentication
          ) "-passfile ${config.age.secrets.${n}.path}"
        }"
      )) [ pkgs.gocryptfs ] [ "cannot:${lib.getExe' pkgs.gocryptfs "gocryptfs"}" ] { };

      ExecStop =
        script "gocryptfs-unmount.sh" (map_cmd (n: v: "fusermount -u ${v.mountpoint}"))
          [
            pkgs.fuse
          ]
          [ ]
          { external = [ "fusermount" ]; };

      # Force gocryptfs and others to use the fusermount wrapper in /run/wrappers/bin, otherwise permissions error occurs.
      Environment = [ "PATH=/run/wrappers/bin" ];
    };
    Install.WantedBy = [ "default.target" ];
  };
}
