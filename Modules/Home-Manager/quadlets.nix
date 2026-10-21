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
    attrByPath
    attrNames
    attrValues
    filterAttrs
    genAttrs
    mapAttrs
    mapAttrsToList
    optionalAttrs
    recursiveUpdate
    removeAttrs
    ;
  inherit (lib.lists)
    concatLists
    elem
    elemAt
    filter
    foldl'
    isList
    optionals
    sort
    ;
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.strings)
    concatMapStringsSep
    concatStringsSep
    escapeShellArg
    hasSuffix
    optionalString
    removePrefix
    removeSuffix
    replaceStrings
    splitString
    stringLength
    substring
    toUpper
    ;
  inherit (lib') deepMerge toSystemdUnit;

  cfg = config.programs.quadlets;

  unitNameConvertor =
    x:
    replaceStrings
      [
        ".container"
        ".network"
        ".volume"
        ".build"
        ".pod"
        ".image"
        ".kube"
      ]
      [
        ".service"
        "-network.service"
        "-volume.service"
        "-build.service"
        "-pod.service"
        "-image.service"
        ".service"
      ]
      x;

  defaultOptions = {
    mkdir = true;
    appendEnv = true;
    unitDefaults = true;
    networkNameAlias = true;
    secretDependency = true;
    mapVolumes = true;
  };

  hasVal =
    set: path:
    let
      v = attrByPath path null set;
    in
    v != null && v != "" && v != [ ] && v != { };

  convertToList =
    v:
    if v == null then
      [ ]
    else if isList v then
      v
    else
      [ v ];

  getVolPath =
    cname:
    (
      if
        hasVal config' [
          "containers"
          cname
          "dir"
        ]
      then
        config'.containers.${cname}.dir
      else
        "${config'.dir.containers}/${
          toUpper (substring 0 1 cname) + substring 1 (stringLength cname) cname
        }"
    )
    + "/";

  mapVolume =
    cname: vol:
    let
      src = elemAt (splitString ":" vol) 0;
    in
    if hasSuffix ":noMap" vol then
      removeSuffix ":noMap" vol
    else if hasSuffix ".volume" src then
      vol
    else
      "${getVolPath cname}${vol}";

  mkdirScript =
    cname: volumes:
    let
      hostDirs =
        volumes |> map (x: elemAt (builtins.split ":" x) 0) |> filter (x: !(hasSuffix ".volume" x));
    in
    pkgs.writeShellScript "${cname}-mkdir" (
      (concatMapStringsSep "\n" (x: "[[ ! -e ${x} ]] && ${pkgs.coreutils}/bin/mkdir -p ${x}") hostDirs)
      + "\nexit 0\n"
    );

  # Phase 1: Pre-Processors
  # Built-in preprocessors executed in order of `order`.
  # Each preprocessor receives: (name: quadlet: options: utils:) -> modified quadlet
  builtInPreprocessors = {
    unitDefaults = {
      order = 100;
      apply =
        _name: quadlet: options: utils:
        if !options.unitDefaults then
          quadlet
        else
          let
            defaults = {
              Install.WantedBy = [ "default.target" ];
              Service = {
                Restart = if utils.isContainer then "always" else "on-failure";
                TimeoutStartSec = 300;
                Type = if utils.isContainer then "notify" else "oneshot";
              };
            }
            // optionalAttrs utils.isContainer {
              Unit = { };
              Container.PodmanArgs = [ "--user 0:0" ];
            };
          in
          recursiveUpdate defaults quadlet;
    };

    networkNameAlias = {
      order = 150;
      apply =
        _name: quadlet: options: utils:
        if !utils.isContainer || !options.networkNameAlias then
          quadlet
        else
          deepMerge {
            Container.PodmanArgs = [ "--network-alias ${quadlet.Container.ContainerName}" ];
          } quadlet;
    };

    mapVolumes = {
      order = 200;
      apply =
        _name: quadlet: options: utils:
        let
          cName = quadlet.Container.ContainerName;
          vols = utils.convertToList quadlet.Container.Volume;
        in
        if
          !utils.isContainer
          || !options.mapVolumes
          || !(hasVal quadlet [
            "Container"
            "Volume"
          ])
        then
          quadlet
        else
          recursiveUpdate quadlet {
            Container.Volume = map (mapVolume cName) vols;
          };
    };

    mkdir = {
      order = 300;
      apply =
        _name: quadlet: options: utils:
        let
          cName = quadlet.Container.ContainerName;
          vols = utils.convertToList (quadlet.Container.Volume or null);
          existingPre = utils.convertToList (quadlet.Service.ExecStartPre or null);
          script =
            if
              utils.isContainer
              && options.mkdir
              && (hasVal quadlet [
                "Container"
                "Volume"
              ])
            then
              mkdirScript cName vols
            else
              null;
        in
        if !utils.isContainer || script == null then
          quadlet
        else
          recursiveUpdate quadlet {
            Service.ExecStartPre = existingPre ++ [ script ];
          };
    };

    appendEnv = {
      order = 400;
      apply =
        _name: quadlet: options: utils:
        let
          cName = quadlet.Container.ContainerName;
          extraEnv = optionals (
            options.appendEnv
            && (hasVal config' [
              "containers"
              cName
              "env"
            ])
          ) config'.containers.${cName}.env;
          existingEnv = utils.convertToList (quadlet.Container.Environment or null);
        in
        if !utils.isContainer then
          quadlet
        else
          recursiveUpdate quadlet {
            Container.Environment = extraEnv ++ existingEnv;
          };
    };

    secretDependency = {
      order = 500;
      apply =
        _name: quadlet: options: utils:
        if
          !utils.isContainer
          || !options.secretDependency
          || !(hasVal quadlet [
            "Container"
            "EnvironmentFile"
          ])
        then
          quadlet
        else
          deepMerge quadlet {
            Unit = {
              Wants = optionals (!(elem "secretspec.service" (quadlet.Unit.Wants or [ ]))) [
                "secretspec.service"
              ];
              After = optionals (!(elem "secretspec.service" (quadlet.Unit.After or [ ]))) [
                "secretspec.service"
              ];
            };
          };
    };
  };

  # Compose pipeline and process quadlets
  activeFns =
    cfg.preprocessors
    |> filterAttrs (_: p: p.enable)
    |> attrValues
    |> sort (a: b: a.order < b.order)
    |> map (p: p.apply);

  pipeline =
    name: initialQuadlet: options: utils:
    foldl' (q: fn: fn name q options utils) initialQuadlet activeFns;

  finalConfig = mapAttrs (
    name: raw:
    let
      options = defaultOptions // (raw.__options or { });
      quadlet = removeAttrs raw [ "__options" ];
      utils = {
        inherit hasVal convertToList;
        isContainer = (hasSuffix ".container" name) || (quadlet ? Container);
        isVolume = (hasSuffix ".volume" name) || (quadlet ? Volume);
        isNetwork = (hasSuffix ".network" name) || (quadlet ? Network);
        isPod = (hasSuffix ".pod" name) || (quadlet ? Pod);
        isImage = (hasSuffix ".image" name) || (quadlet ? Image);
        isBuild = (hasSuffix ".build" name) || (quadlet ? Build);
        isKube = (hasSuffix ".kube" name) || (quadlet ? Kube);
      };
    in
    pipeline name quadlet options utils
  ) cfg.quadlets;

  unitFilesFor =
    qName: quadlet:
    let
      unit = unitNameConvertor qName;
      install = quadlet.Install or { };
    in
    [ unit ]
    ++ map (t: "${t}.wants/${unit}") (convertToList (install.WantedBy or null))
    ++ map (t: "${t}.requires/${unit}") (convertToList (install.RequiredBy or null))
    ++ map (t: "${t}.upholds/${unit}") (convertToList (install.UpheldBy or null))
    ++ (convertToList (install.Alias or null));

  allUnitFiles = concatLists (mapAttrsToList unitFilesFor finalConfig);
in
{
  options.programs.quadlets = {
    enable = mkEnableOption "Podman's Quadlets";

    quadlets = mkOption {
      default = { };
      type = types.attrsOf (types.attrsOf (types.either types.anything (types.listOf types.anything)));
      description = ''
        Declarative Podman Quadlet configurations keyed by unit file name (e.g. "caddy.container", "app.volume").
        Per-unit preprocessing options can be specified under `__options` (e.g., `__options.mapVolumes = false;`).
      '';
    };

    preprocessors = mkOption {
      type = types.attrsOf (
        types.submodule {
          options = {
            enable = mkOption {
              type = types.bool;
              default = true;
              description = "Whether this preprocessor step is enabled.";
            };
            order = mkOption {
              type = types.int;
              default = 1000;
              description = "Execution order in the preprocessing pipeline (lower executes first).";
            };
            apply = mkOption {
              type = types.functionTo (types.functionTo (types.functionTo (types.functionTo types.attrs)));
              description = "Function taking `name: quadlet: options: utils:` returning modified quadlet. `utils` provides: `convertToList`, `hasVal`, and unit type helpers (`isContainer`, `isVolume`, `isNetwork`, `isPod`, `isImage`, `isBuild`, `isKube`).";
            };
          };
        }
      );
      default = { };
      description = ''
        Customizable pipeline of preprocessing modules executed in order of `order`.
        Built-ins: `unitDefaults` (100), `networkNameAlias` (150), `mapVolumes` (200), `mkdir` (300), `appendEnv` (400), `secretDependency` (500).
        Built-in steps can be disabled via `programs.quadlets.preprocessors.<name>.enable = false;`.
      '';
    };

    stripSourcePath = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to strip SourcePath= from generated unit files to prevent unnecessary restarts.";
    };

    finalQuadlets = mkOption {
      type = types.attrsOf types.anything;
      description = "Final Quadlet Configuration after preprocessing.";
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

    buildQuadlets = mkOption {
      type = types.attrsOf types.attrs;
      readOnly = true;
      description = "Exposed map of all declared .build quadlets and their build specifications.";
      default =
        cfg.quadlets
        |> filterAttrs (n: q: (hasSuffix ".build" n) || (q ? Build))
        |> mapAttrs (
          n: q: {
            name = removeSuffix ".build" n;
            unitName = n;
            imageTag = q.Build.ImageTag or (removeSuffix ".build" n);
            file = q.Build.File or null;
            setWorkingDirectory = q.Build.SetWorkingDirectory or null;
            raw = q.Build;
          }
        );
    };
  };

  config = mkIf cfg.enable (
    let
      badUnits = filterAttrs (
        name: q:
        let
          isContainer = (hasSuffix ".container" name) || (q ? Container);
          isVolume = (hasSuffix ".volume" name) || (q ? Volume);
          isNetwork = (hasSuffix ".network" name) || (q ? Network);
        in
        (
          isContainer
          && !(hasVal q [
            "Container"
            "ContainerName"
          ])
        )
        || (
          isVolume
          && !(hasVal q [
            "Volume"
            "VolumeName"
          ])
        )
        || (
          isNetwork
          && !(hasVal q [
            "Network"
            "NetworkName"
          ])
        )
      ) cfg.quadlets;

      assertions = mapAttrsToList (
        name: q:
        let
          isContainer = (hasSuffix ".container" name) || (q ? Container);
          isVolume = (hasSuffix ".volume" name) || (q ? Volume);
          kind =
            if isContainer then
              "Container.ContainerName"
            else if isVolume then
              "Volume.VolumeName"
            else
              "Network.NetworkName";
        in
        {
          assertion = false;
          message = "programs.quadlets.quadlets.\"${name}\": Must specify '${kind}'.";
        }
      ) badUnits;

      allQuadletsDir = pkgs.linkFarm "quadlets-src" (
        mapAttrs (qName: qVal: pkgs.writeText qName (toSystemdUnit qVal)) finalConfig
      );

      # Phase 2 & 3 - Generating using `pkgs.runCommand` and verification of list
      generatedUnits = pkgs.runCommand "quadlet-units" { } ''
        mkdir -p $out
        QUADLET_UNIT_DIRS=${allQuadletsDir} ${osConfig.virtualisation.podman.package}/libexec/podman/quadlet -user $out

        (
          cd $out
          for file in $(find . -type f | sed 's|^\./||'); do
            substituteInPlace "$file" \
              --replace-quiet ${allQuadletsDir}/\$\{XDG_RUNTIME_DIR} \$\{XDG_RUNTIME_DIR} \
              --replace-quiet \\x20 " "
            ${optionalString cfg.stripSourcePath ''
              sed -i '/^SourcePath=/d' "$file"
            ''}
          done
        )

        expected=${escapeShellArg (concatStringsSep "\n" allUnitFiles)}
        while IFS= read -r f; do
          if ! grep -qxF -- "$f" <<< "$expected"; then
            echo "[quadlet-generator] unexpected generator output: $f" >&2
            exit 1
          fi
        done < <(cd $out && find . \( -type f -o -type l \) | sed 's|^\./||' | sort)
      '';
    in
    {
      programs.quadlets.preprocessors = builtInPreprocessors;

      inherit assertions;

      # Phase 3: Final linking
      xdg.configFile = genAttrs (map (f: "systemd/user/${f}") allUnitFiles) (f: {
        source = "${generatedUnits}/${removePrefix "systemd/user/" f}";
      });
    }
  );
}
