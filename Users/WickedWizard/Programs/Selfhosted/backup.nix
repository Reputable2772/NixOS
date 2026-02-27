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
    cmd: "${pkgs.systemd}/bin/systemctl --user ${cmd} " + config.programs.quadlets.servicesList;

  inherit (lib.attrsets)
    filterAttrs
    hasAttrByPath
    mapAttrsToList
    ;
  inherit (lib.lists) elem elemAt;
  inherit (lib.strings)
    concatMapAttrsStringSep
    hasSuffix
    optionalString
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
      "${tmpLocation}/${qval.Volume.VolumeName}.tar.gz"
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
      passwordFile =
        lib.replaceStrings [ "$\{XDG_RUNTIME_DIR}" ] [ "%t" ]
          config.age.secrets.containers-backup-pwd.path;
      backupPrepareCommand = ''
        ${(containerCommand "stop")}
        mkdir -p ${tmpLocation}

        # Needed for volume export, since it uses setuidmap & setgidmap
        export PATH="/run/wrappers/bin:$PATH"
        ${concatMapAttrsStringSep "\n"
          (
            qname: qval:
            "${pkgs.podman}/bin/podman volume export ${qval.Volume.VolumeName} --output ${tmpLocation}/${qval.Volume.VolumeName}.tar.gz"
          )
          (
            filterAttrs (n: v: hasAttrByPath [ "Volume" "VolumeName" ] v) config.programs.quadlets.finalQuadlets
          )
        }
      '';
      backupCleanupCommand = containerCommand "start";

      initialize = true;
      timerConfig = {
        OnCalendar = "*-*-* 21:00:00";
        Persistent = true;
      };
      inhibitsSleep = true;
      extraBackupArgs = [ "--compression max" ];
    };
  };

  # Needed for volume export, since it uses setuidmap & setgidmap
  systemd.user.services.restic-backups-containers.Service.Delegate = true;
  systemd.user.services.restic-backups-containers.Service.PrivateTmp = lib.mkForce false;
}
