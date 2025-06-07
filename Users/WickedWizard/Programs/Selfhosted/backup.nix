{
  config',
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config'.containers.backup) pwdFile blacklistedPaths location;
  tmpLocation = "${config.home.homeDirectory}/tmp-container-backup";
  containerCommand =
    cmd:
    "systemctl --user ${cmd} "
    + (concatMapStringsSep " " (
      x:
      replaceStrings
        [ ".container" ".network" ".volume" ]
        [ ".service" "-network.service" "-volume.service" ]
        x
    ) (attrNames config.programs.quadlets.quadlets));

  inherit (lib.attrsets) attrNames hasAttrByPath mapAttrsToList;
  inherit (lib.lists) elem elemAt;
  inherit (lib.strings)
    concatStringsSep
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
      hasAttrByPath [ "Container" "ContainerName" ] qval && hasAttrByPath [ "Container" "Volume" ] qval
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
  ) config.programs.quadlets.quadlets;
in
{
  age.secrets.containers-backup-pwd.file = ./. + "../../../../../Config/${pwdFile}.age";

  systemd.user.services.containers-backup = {
    Unit = {
      Description = "Containers backup";
    };

    Service = {
      Type = "oneshot";
      ExecStartPre = pkgs.writeShellScript "pre-containers-backup" ''
        mkdir -p ${tmpLocation}
        cat ${pkgs.writeText "staticPaths" (lib.concatLines (lib.flatten paths))} >> ${tmpLocation}/paths.txt
      '';
      ExecStart = pkgs.writeShellScript "containers-backup" (
        concatStringsSep "\n" [
          (containerCommand "stop")
          # Create volume.tar.gz files for volume backups only.
          (concatMapAttrsStringSep "\n" (
            qname: qval:
            if hasAttrByPath [ "Volume" "VolumeName" ] qval then
              ''
                mkdir -p ${tmpLocation}/${qval.Volume.VolumeName}
                ${pkgs.podman}/bin/podman volume export ${qval.Volume.VolumeName} --output ${tmpLocation}/${qval.Volume.VolumeName}/${qval.Volume.VolumeName}.tar.gz
              ''
            else
              ""
          ) config.programs.quadlets.quadlets)
          # Setting this environment variable directly inside Service.Environment doesn't work for some reason.
          "export RESTIC_PASSWORD_FILE=${config.age.secrets.containers-backup-pwd.path}"
          "export RESTIC_REPOSITORY=${location}"
          "${pkgs.restic}/bin/restic backup --files-from=${tmpLocation}/paths.txt"
          (containerCommand "start")
        ]
      );
    };
  };

  systemd.user.timers.containers-backup = {
    Unit = {
      Description = "Backup Podman Containers regularly.";
    };

    Timer = {
      OnCalendar = [ "*-*-* 00/12:00:00" ];
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
