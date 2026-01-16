{
  config,
  config',
  pkgs,
  lib,
  ...
}:
let
  cfg = config'.mounts.gocryptfs or { };
  enabled = cfg != { };
in
{
  home.packages = lib.optionals enabled [ pkgs.gocryptfs ];

  age.secrets = lib.mkIf enabled (
    lib.mapAttrs' (n: _: {
      name = n;
      value.file = ./. + "../../../../Config/${n}.age";
    }) (lib.filterAttrs (_: v: v.authentication or false) cfg)
  );

  systemd.user.services = lib.mkIf enabled (
    lib.mapAttrs' (n: v: {
      name = "gocryptfs-${n}";
      value = {
        Unit.Description = "Mount gocryptfs: ${n}";
        Service = {
          Type = "simple";
          Restart = "on-failure";
          RestartSec = "5s";
          Environment = [ "PATH=/run/wrappers/bin" ];
          ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${v.mountpoint}";
          ExecStart =
            "${lib.getExe' pkgs.gocryptfs "gocryptfs"} -f "
            + lib.optionalString (v.authentication or false) "-passfile ${config.age.secrets.${n}.path} "
            + "${v.source} ${v.mountpoint}";
          ExecStop = "fusermount -u -z ${v.mountpoint}";
        };
        Install.WantedBy = [ "default.target" ];
      };
    }) cfg
  );
}
