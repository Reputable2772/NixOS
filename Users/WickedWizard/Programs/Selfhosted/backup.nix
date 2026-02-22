{
  config',
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config'.containers.backup)
    pwdFile
    blacklistedContainers
    blacklistedPaths
    location
    ;
  tmpLocation = "${config.home.homeDirectory}/.cache/containers-backup";
  containerCommand =
    cmd:
    "systemctl --user ${cmd} "
    + (concatMapStringsSep " " (
      x:
      replaceStrings
        [ ".container" ".network" ".volume" ]
        [ ".service" "-network.service" "-volume.service" ]
        x
    ) (attrNames config.programs.quadlets.finalQuadlets));

  inherit (lib.attrsets) attrNames hasAttrByPath mapAttrsToList;
  inherit (lib.lists) elem elemAt;
  inherit (lib.strings)
    concatMapStringsSep
    concatMapAttrsStringSep
    hasSuffix
    optionalString
    replaceStrings
    splitString
    ;

  paths = mapAttrsToList (
    qname: qval:
    if
      hasAttrByPath [ "Container" "ContainerName" ] qval
      # Container must not be blacklisted.
      && !(elem qname blacklistedContainers || elem qval.Container.ContainerName blacklistedContainers)
      && hasAttrByPath [ "Container" "Volume" ] qval
    then
      map (
        vname:
        let
          src = elemAt (splitString ":" vname) 0;
          mpt = elemAt (splitString ":" vname) 1;
        in
        optionalString (
          # Should not be a podman volume.
          !(hasSuffix ".volume" src)
          # The volume mount format is src:mpt. Neither src, nor mpt, not src:mpt must be in blacklistedPaths
          && !(elem src blacklistedPaths || elem mpt blacklistedPaths || elem vname blacklistedPaths)
        ) src
      ) qval.Container.Volume
    else if hasAttrByPath [ "Volume" "VolumeName" ] qval then
      "${tmpLocation}/${qval.Volume.VolumeName}"
    else
      ""
  ) config.programs.quadlets.finalQuadlets;
in
{
  age.secrets.containers-backup-pwd.file = ./. + "../../../../../Config/${pwdFile}.age";

  services.restic = {
    enable = true;
    backups.containers = {
      repository = location;
      paths = lib.flatten paths;
      passwordFile = config.age.secrets.containers-backup-pwd.path;
      backupPrepareCommand = "${pkgs.writeShellScript "container-backup-prepare" (
        "mkdir -p ${tmpLocation}\n"
        + (concatMapAttrsStringSep "\n" (
          qname: qval:
          if hasAttrByPath [ "Volume" "VolumeName" ] qval then
            "${pkgs.podman}/bin/podman volume export ${qval.Volume.VolumeName} --output ${tmpLocation}/${qval.Volume.VolumeName}.tar.gz"
          else
            ""
        ) config.programs.quadlets.finalQuadlets)
        + "\n"
        + (containerCommand "stop")
        + "\n"
      )}";
      backupCleanupCommand = "${pkgs.writeShellScript "container-backup-cleanup" (
        containerCommand "stop"
      )}";

      initialize = true;
      timerConfig = {
        OnCalendar = "*-*-* 21:00:00";
        Persistent = true;
      };
      inhibitsSleep = true;
      extraBackupArgs = [ "--compression max" ];
    };
  };
}
