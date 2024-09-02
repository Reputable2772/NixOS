{ config, config', lib, ... }:
let
  inherit (lib.attrsets) mapAttrs mapAttrs' mapAttrsToList nameValuePair;
  inherit (lib.modules) mkIf;
  inherit (lib.strings) concatStringsSep;

  only = cond: mkIf (config'.system.${config.networking.hostName}.mounts ? bitlocker && config'.system.${config.networking.hostName}.mounts.bitlocker != null) cond;
in
{
  systemd.generators.systemd-cryptsetup-generator = only "${config.systemd.package}/lib/systemd/system-generators/systemd-cryptsetup-generator";

  age.secrets = only (mapAttrs (n: v: { file = ./. + "../../../../Config/${n}.age"; }) config'.system.${config.networking.hostName}.mounts.bitlocker);

  environment.etc.crypttab.text = only
    (concatStringsSep "\n"
      (mapAttrsToList
        (n: v: "${n} ${v.source} ${if v.authentication then "${config.age.secrets.${n}.path} " else "- noauto,"}bitlk")
        config'.system.${config.networking.hostName}.mounts.bitlocker));

  fileSystems = only
    (mapAttrs'
      (n: v: nameValuePair v.mountpoint {
        depends = [
          "/home"
        ];
        device = "/dev/mapper/${n}";
        inherit (v) fsType;
      })
      config'.system.${config.networking.hostName}.mounts.bitlocker);
}