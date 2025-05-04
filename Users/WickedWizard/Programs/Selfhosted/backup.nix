{
  config',
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config'.containers.backup) blacklistedPaths location;
  containerCommand =
    cmd:
    "systemctl --user ${cmd} "
    + (concatMapStringsSep " " (
      x:
      replaceStrings
        [ ".container" ".network" ".volume" ]
        [ ".service" "-network.service" "-volume.service" ]
        x
    ) (attrNames config.programs.quadlets.quadlets))
    + "\n";

  inherit (lib.attrsets) attrNames hasAttrByPath;
  inherit (lib.lists) elem elemAt;
  inherit (lib.strings)
    concatMapStringsSep
    concatMapAttrsStringSep
    hasSuffix
    optionalString
    replaceStrings
    splitString
    ;
in
{
  programs.backup.preBackupScript = [
    ''
      systemctl --user start containers-backup.service
    ''
  ];

  systemd.user.services.containers-backup = {
    Unit = {
      Description = "Containers backup";
    };

    Service = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "containers-backup" (
        "mkdir -p ${location}"
        + "\n"
        + containerCommand "stop"
        + (concatMapAttrsStringSep "\n" (
          qname: qval:
          if
            hasAttrByPath [ "Container" "ContainerName" ] qval && hasAttrByPath [ "Container" "Volume" ] qval
          then
            concatMapStringsSep "\n" (
              vname:
              let
                src = elemAt (splitString ":" vname) 0;
                mpt = elemAt (splitString ":" vname) 1;
                qcname = elemAt (splitString "." qname) 0;
              in
              optionalString
                (
                  # Should not be a podman volume.
                  !(hasSuffix ".volume" src)
                  # The volume mount format is src:mpt. Neither src, nor mpt, not src:mpt must be in blacklistedPaths
                  && !(elem src blacklistedPaths || elem mpt blacklistedPaths || elem vname blacklistedPaths)
                )
                ''
                  mkdir -p ${location}/${qcname}
                  cp -r ${src} ${location}/${qcname}/$(basename ${src})
                ''
            ) qval.Container.Volume
          else if hasAttrByPath [ "Volume" "VolumeName" ] qval then
            "${pkgs.podman}/bin/podman volume export ${qval.Volume.VolumeName} --output ${location}/${qval.Volume.VolumeName}.tar.gz"
          else
            ""
        ) config.programs.quadlets.quadlets)
        + containerCommand "start"
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
