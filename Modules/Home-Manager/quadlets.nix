{
  osConfig,
  config,
  config',
  pkgs,
  lib,
  lib',
  ...
}:

let
  inherit (lib) types;
  inherit (lib.attrsets)
    attrNames
    filterAttrs
    hasAttrByPath
    optionalAttrs
    mapAttrs
    getAttrFromPath
    recursiveUpdate
    removeAttrs
    ;
  inherit (lib.lists)
    elemAt
    foldl'
    filter
    isList
    map
    ;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.strings)
    concatMapStringsSep
    concatStringsSep
    hasInfix
    hasSuffix
    optionalString
    replaceStrings
    splitString
    removeSuffix
    ;

  cfg = config.programs.quadlets;
  qType =
    with types;
    let
      primitive = oneOf [
        bool
        int
        str
        path
      ];
    in
    attrsOf (attrsOf (attrsOf (either primitive (listOf primitive))))
    // {
      description = "Quadlet configuration.";
    };

  unitNameConvertor =
    x:
    replaceStrings
      [ ".container" ".network" ".volume" ]
      [ ".service" "-network.service" "-volume.service" ]
      x;

  # All the below code -
  # Pre-processes all quadlets written by user,
  # and stores them into finalConfig.
  defaultOptions = {
    mkdir = true;
    appendEnv = true;
    appendEnvFiles = true;
    unitDefaults = true;
    # Opt out either with this flag, or by setting :noMap at the end of a specific volume
    mapVolumes = true;
  };

  isContainer = q: hasAttrByPath [ "Container" "ContainerName" ] q;
  getVolPathFromConfig =
    cname:
    (
      if config'.containers.${cname} ? dir && config'.containers.${cname}.dir != null then
        config'.containers.${cname}.dir
      else
        "${config'.dir.containers}/${
          lib.strings.toUpper (lib.strings.substring 0 1 cname)
          + lib.strings.substring 1 (lib.strings.stringLength cname + 1) cname
        }"
    )
    + "/";
  volumeMapper = qVal: {
    Container.Volume = map (
      vol:
      # Skip mapping volumes if they have a :noMap suffix, or if they are a Podman Volume.
      if ((hasSuffix ":noMap" vol) || (hasSuffix ".volume" (elemAt (splitString ":" vol) 0))) then
        (removeSuffix ":noMap" vol)
      else
        ((getVolPathFromConfig qVal.Container.ContainerName) + vol)
    ) qVal.Container.Volume;
  };

  unitDefaults =
    qVal:
    {
      Install.WantedBy = [ "default.target" ];
      Service = {
        Restart = if (isContainer qVal) then "always" else "on-failure";
        TimeoutStartSec = 300;
        Type = if (isContainer qVal) then "notify" else "oneshot";
      };
    }
    // optionalAttrs (isContainer qVal) {
      Container.PodmanArgs = "--network-alias ${qVal.Container.ContainerName} --user 0:0";
    };

  mkdirOp = qVal: {
    Service.ExecStartPre =
      lib.optional
        (
          hasAttrByPath [
            "Container"
            "Volume"
          ] qVal
          && (qVal.Container.Volume != null || qVal.Container.Volume != [ ])
        )
        (
          qVal.Container.Volume
          |> map (x: builtins.elemAt (builtins.split ":" x) 0)
          |> filter (x: !(hasSuffix ".volume" x))
          |> concatMapStringsSep "\n" (x: "[[ ! -e ${x} ]] && ${pkgs.coreutils}/bin/mkdir -p ${x}")
          |> (a: pkgs.writeShellScript "${qVal.Container.ContainerName}-mkdir" (a + "\nexit 0\n"))
        );
  };

  appendEnv = qVal: {
    Container.Environment = lib.optionals (
      config'.containers.${qVal.Container.ContainerName} ? env
      && config'.containers.${qVal.Container.ContainerName}.env != null
    ) config'.containers.${qVal.Container.ContainerName}.env;
  };

  appendEnvFiles = qVal: {
    Container.EnvironmentFile =
      lib.optionals
        (
          config'.containers.${qVal.Container.ContainerName} ? envFiles
          && config'.containers.${qVal.Container.ContainerName}.envFiles != null
        )
        (
          lib.lists.map (
            n: config.age.secrets.${n}.path
          ) config'.containers.${qVal.Container.ContainerName}.envFiles
        );
  };

  finalConfig = mapAttrs (
    qName: qVal:
    let
      # Merge container & default options.
      quadletOptions = defaultOptions // (qVal.__options or { });

      # Map only volumes separately, since volumes have to be overwritten entirely,
      # rather than be merged.
      mappedVolumes =
        if
          (
            (isContainer qVal)
            && quadletOptions.mapVolumes
            && (hasAttrByPath [
              "Container"
              "Volume"
            ] qVal)
            && qVal.Container.Volume != null
          )
        then
          # recursiveUpdate is used on purpose here, since it overwrites lists instead of merging them.
          (recursiveUpdate qVal (volumeMapper qVal))
        else
          qVal;
      preProcess = foldl' (acc: elem: (lib'.deepMerge (elem acc) acc)) mappedVolumes (
        [
          (f: optionalAttrs quadletOptions.unitDefaults (unitDefaults f))
        ]
        ++ (lib.optionals (isContainer qVal) [
          (f: optionalAttrs quadletOptions.mkdir (mkdirOp f))
          (f: optionalAttrs quadletOptions.appendEnv (appendEnv f))
          (f: optionalAttrs quadletOptions.appendEnvFiles (appendEnvFiles f))
        ])
      );
    in
    # Remove __options if defined.
    removeAttrs preProcess [ "__options" ]
  ) cfg.quadlets;

  volumesList =
    finalConfig
    |> (filterAttrs (qName: qVal: hasAttrByPath [ "Volume" "VolumeName" ] qVal))
    |> mapAttrs (volName: volVal: pkgs.writeTextDir volName (lib'.toSystemdUnit volVal));
  networksList =
    finalConfig
    |> (filterAttrs (qName: qVal: hasAttrByPath [ "Network" "NetworkName" ] qVal))
    |> mapAttrs (netName: netVal: pkgs.writeTextDir netName (lib'.toSystemdUnit netVal));
in
{
  options.programs.quadlets = {
    enable = mkEnableOption "Podman's Quadlets";
    quadlets = mkOption {
      default = { };
      type = qType;
      description = "All the quadlets that need to have systemd unit files generated";
    };
    finalQuadlets = mkOption {
      type = qType;
      description = "Final Quadlet Configuration";
      default = finalConfig;
      readOnly = true;
    };
    extraServices = mkOption {
      default = [ ];
      type = types.listOf types.str;
      description = "A list of extra systemd services that are relied upon by containers.";
    };
    servicesList = mkOption {
      type = types.str;
      description = "A list of all the systemd services that are used to control quadlets.";
      default = concatMapStringsSep " " unitNameConvertor ((attrNames cfg.quadlets) ++ cfg.extraServices);
    };
  };

  config = lib.mkIf cfg.enable (
    let
      generatedQuadlets = mapAttrs (
        qName: qVal:
        pkgs.runCommand "quadlet-generator-${qName}" { } (
          let
            convertToList =
              val:
              if ((hasAttrByPath val qVal) && (getAttrFromPath val qVal != null)) then
                (
                  let
                    retVal = (getAttrFromPath val qVal);
                  in
                  if isList retVal then retVal else [ retVal ]
                )
              else
                [ ];

            networks = map (network: networksList.${network}) (convertToList [
              "Container"
              "Network"
            ]);
            volumes = map (vol: volumesList.${elemAt (splitString ":" vol) 0}) (
              filter (vol: hasInfix ".volume" vol) (convertToList [
                "Container"
                "Volume"
              ])
            );

            quadletFile = pkgs.writeTextDir qName (lib'.toSystemdUnit qVal);
          in
          ''
            QUADLET_UNIT_DIRS=${quadletFile}${
              optionalString (networks != [ ]) (":" + (concatStringsSep ":" networks))
            }${
              optionalString (volumes != [ ]) (":" + (concatStringsSep ":" volumes))
            } ${osConfig.virtualisation.podman.package}/libexec/podman/quadlet -user $out

            for file in $(find $out -type f -exec realpath --relative-to $out {} \;); do
              substituteInPlace $out/$file \
                --replace-warn ${quadletFile}/\$\{XDG_RUNTIME_DIR} \$\{XDG_RUNTIME_DIR} \
                --replace-warn \\x20 " "
            done
          ''
        )
      ) finalConfig;

      mapDirToXdg =
        prefix: dir:
        lib.foldl' (acc: ext: acc // ext) { } (
          lib.mapAttrsToList (
            name: type:
            let
              path = "${dir}/${name}";
              targetPath = "${prefix}/${name}";
            in
            if type == "directory" then
              mapDirToXdg targetPath path
            else
              {
                "${targetPath}" = {
                  source = path;
                };
              }
          ) (builtins.readDir dir)
        );
    in
    {
      xdg.configFile = foldl' (acc: pkg: acc // mapDirToXdg "systemd/user" pkg) { } (
        builtins.attrValues generatedQuadlets
      );
    }
  );
}
