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
  inherit (lib) strings types;
  inherit (lib.attrsets)
    attrNames
    filterAttrs
    hasAttrByPath
    optionalAttrs
    mapAttrs
    mapAttrsToList
    listToAttrs
    nameValuePair
    getAttrFromPath
    recursiveUpdate
    ;
  inherit (lib.lists)
    concatLists
    elemAt
    foldl'
    filter
    isList
    optional
    optionals
    ;
  inherit (lib.modules) mkIf;
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
      [ ".container" ".network" ".volume" ".build" ]
      [ ".service" "-network.service" "-volume.service" "-build.service" ]
      x;

  # All the below code -
  # Pre-processes all quadlets written by user,
  # and stores them into finalConfig.
  defaultOptions = {
    mkdir = true;
    appendEnv = true;
    unitDefaults = true;
    networkNameAlias = true;
    secretDependency = true;
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
          strings.toUpper (strings.substring 0 1 cname)
          + strings.substring 1 (strings.stringLength cname + 1) cname
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
    qVal: qOpts:
    {
      Install.WantedBy = [ "default.target" ];
      Service = {
        Restart = if (isContainer qVal) then "always" else "on-failure";
        TimeoutStartSec = 300;
        Type = if (isContainer qVal) then "notify" else "oneshot";
      };
    }
    // optionalAttrs (isContainer qVal) {
      Container.PodmanArgs = "${optionalString qOpts.networkNameAlias "--network-alias ${qVal.Container.ContainerName}"} --user 0:0";
    };

  mkdirOp = qVal: {
    Service.ExecStartPre =
      optional
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
    Container.Environment = optionals (
      config'.containers.${qVal.Container.ContainerName} ? env
      && config'.containers.${qVal.Container.ContainerName}.env != null
    ) config'.containers.${qVal.Container.ContainerName}.env;
  };

  secretDependency =
    qVal:
    let
      _envFiles = qVal.Container.EnvironmentFile or [ ];
      envFiles = if isList _envFiles then _envFiles else [ _envFiles ];
    in
    {
      Unit = optionalAttrs (envFiles != [ ]) {
        Wants = [ "secretspec.service" ];
        After = [ "secretspec.service" ];
      };
    };

  finalConfig = mapAttrs (
    qName: qVal:
    let
      # Merge container & default options.
      quadletOptions = defaultOptions // (qVal.__options or { });

      /**
        Ideal Preprocessing ordering -
        unitDefaults -> appendEnv  -> secretDependency -> mapVolumes (special) -> mkdirOp

        Current ordering
        mapVolumes (special) -> unitDefaults -> mkdirOp -> appendEnv -> secretDependency
      */

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
          # Temp fix for hp-laptop not using bridge networking.
          # TODO: Write a better pre-processing script later.
          (f: optionalAttrs quadletOptions.unitDefaults (unitDefaults f quadletOptions))
        ]
        ++ (optionals (isContainer qVal) [
          (f: optionalAttrs quadletOptions.mkdir (mkdirOp f))
          (f: optionalAttrs quadletOptions.appendEnv (appendEnv f))
          (f: optionalAttrs quadletOptions.secretDependency (secretDependency f))
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
  buildsList =
    finalConfig
    |> (filterAttrs (qName: qVal: hasAttrByPath [ "Build" "ImageTag" ] qVal))
    |> (mapAttrs (bName: bVal: pkgs.writeTextDir bName (lib'.toSystemdUnit bVal)));
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

  config = mkIf cfg.enable (
    let
      /**
        Instead of using a builtins.readFile IFD for every single
        quadlet (which slows down the eval/build entirely), here's a
        small workaround.

        We instead "predict" all the files the quadlet generator will
        generate (from [Install].WantedBy, RequiredBy, etc.) and map
        those files manually to .config/systemd/user.

        This *does not* work with ServiceName overrides and uninstantiated
        template units.
      */
      expectedUnitFiles =
        qName:
        let
          unit = unitNameConvertor qName;
          install = finalConfig.${qName}.Install or { };

          asList = value: if isList value then value else [ value ];

          linksFor = dir: key: map (target: "${target}.${dir}/${unit}") (asList (install.${key} or [ ]));
        in
        [ unit ]
        ++ linksFor "wants" "WantedBy"
        ++ linksFor "requires" "RequiredBy"
        ++ linksFor "upholds" "UpheldBy"
        ++ asList (install.Alias or [ ]);

      generatedQuadlets = mapAttrs (
        qName: qVal:
        pkgs.runCommand "quadlet-generator-${qName}" { } (
          let
            normalizeList =
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

            networks = map (network: networksList.${network}) (
              filter (net: hasSuffix ".network" net) (normalizeList [
                "Container"
                "Network"
              ])
            );
            volumes = map (vol: volumesList.${elemAt (splitString ":" vol) 0}) (
              filter (vol: hasInfix ".volume" vol) (normalizeList [
                "Container"
                "Volume"
              ])
            );
            builds =
              if ((hasAttrByPath [ "Container" "Image" ] qVal) && hasSuffix ".build" qVal.Container.Image) then
                buildsList.${qVal.Container.Image}
              else
                "";

            quadletFile = pkgs.writeTextDir qName (lib'.toSystemdUnit qVal);

            # Names of the quadlets referenced above. The generator also emits their
            # units, since they are in QUADLET_UNIT_DIRS (used by the debug check only).
            depNames =
              filter (net: hasSuffix ".network" net) (normalizeList [
                "Container"
                "Network"
              ])
              ++ map (vol: elemAt (splitString ":" vol) 0) (
                filter (vol: hasInfix ".volume" vol) (normalizeList [
                  "Container"
                  "Volume"
                ])
              )
              ++ lib.optional (builds != "") qVal.Container.Image;
          in
          ''
            QUADLET_UNIT_DIRS=${quadletFile}${
              optionalString (networks != [ ]) (":" + (concatStringsSep ":" networks))
            }${optionalString (volumes != [ ]) (":" + (concatStringsSep ":" volumes))}${
              optionalString (builds != "") (":" + builds)
            } ${osConfig.virtualisation.podman.package}/libexec/podman/quadlet -user $out

            for file in $(find $out -type f -exec realpath --relative-to $out {} \;); do
              substituteInPlace $out/$file \
                --replace-quiet ${quadletFile}/\$\{XDG_RUNTIME_DIR} \$\{XDG_RUNTIME_DIR} \
                --replace-quiet \\x20 " "
            done

            # TEMP DEBUG: report generator output that is not in expectedUnitFiles,
            # counting the units of referenced networks/volumes/builds as expected.
            # Logs only (does not fail the build). Remove once the list is trusted.
            expected=${
              lib.escapeShellArg (concatStringsSep "\n" (lib.concatMap expectedUnitFiles ([ qName ] ++ depNames)))
            }
            while IFS= read -r f; do
              if ! grep -qxF -- "$f" <<< "$expected"; then
                echo "[quadlet-debug] ${qName}: unexpected generator output: $f" >&2
                exit 1
              fi
            done < <(cd $out && find . \( -type f -o -type l \) | sed 's|^\./||' | sort)
          ''
        )
      ) finalConfig;
    in
    {
      xdg.configFile = listToAttrs (
        concatLists (
          mapAttrsToList (
            qName: pkg:
            map (
              unitFile:
              nameValuePair "systemd/user/${unitFile}" {
                source = "${pkg}/${unitFile}";
              }
            ) (expectedUnitFiles qName)
          ) generatedQuadlets
        )
      );
    }
  );
}
