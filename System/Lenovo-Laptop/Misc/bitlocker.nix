{
  config,
  config',
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.attrsets)
    mapAttrs'
    nameValuePair
    ;
  inherit (lib.modules) mkIf;
  inherit (lib.strings) optionalString;

  onlyIf =
    cond:
    mkIf (
      config'.system.${config.networking.hostName}.mounts ? bitlocker
      && config'.system.${config.networking.hostName}.mounts.bitlocker != null
    ) cond;
in
{
  secretspec.config.profiles.lenovo-laptop = onlyIf (
    mapAttrs' (
      n: v: nameValuePair n { description = "Bitlocker key for volume ${n}"; }
    ) config'.system.${config.networking.hostName}.mounts.bitlocker
  );

  systemd.services = onlyIf (
    mapAttrs' (
      n: v:
      nameValuePair "bitlocker-${n}" {
        description = "Unlock ${n} BitLocker volume";
        after = [
          "local-fs.target"
          "agenix.service"
        ];
        wants = [ "agenix.service" ];

        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;

          ExecStart = ''
            ${pkgs.cryptsetup}/bin/cryptsetup open \
              --type bitlk \
              ${optionalString v.authentication "--key-file ${config.secretspec.secrets.profiles.lenovo-laptop.${n}.plainPath}"} \
              ${v.source} ${n}
          '';
          ConditionPathExists = "!/dev/mapper/${n}";
        };
      }
    ) config'.system.${config.networking.hostName}.mounts.bitlocker
  );

  fileSystems = onlyIf (
    mapAttrs' (
      n: v:
      nameValuePair v.mountpoint {
        depends = [
          "/home"
        ];
        device = "/dev/mapper/${n}";
        inherit (v) fsType;
        options = [
          "rw"
          "noauto"
          "uid=1000"
          "gid=100"
          "x-systemd.after=bitlocker-${n}.service"
          "x-systemd.requires=bitlocker-${n}.service"
          "x-systemd.automount"
          "x-systemd.idle-timeout=5min"
        ]
        ++ lib.optional v.nofail "nofail";
      }
    ) config'.system.${config.networking.hostName}.mounts.bitlocker
  );
}
