{
  config,
  config',
  pkgs,
  lib,
  ...
}:
let
  cfg = config'.mounts.gocryptfs or { };
  authenticatedMounts = lib.filterAttrs (n: v: v.authentication or false) cfg;
  enabled = cfg != { };
in
{
  home.packages = lib.optionals enabled [ pkgs.gocryptfs ];

  secretspec.config.profiles.wickedwizard = lib.optionalAttrs (authenticatedMounts != { }) (
    lib.mapAttrs' (name: mount: {
      inherit name;
      value.description = "gocryptfs password file - ${name}";
    }) authenticatedMounts
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
            +
              lib.optionalString (v.authentication or false)
                "-passfile ${config.secretspec.secrets.profiles.wickedwizard.${n}.plainPath} "
            + "${v.source} ${v.mountpoint}";
          ExecStop = "fusermount -u -z ${v.mountpoint}";
        };
        Install.WantedBy = [ "default.target" ];
      };
    }) cfg
  );
}
