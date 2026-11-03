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
    listToAttrs
    mapAttrs
    mapAttrsToList
    nameValuePair
    optionalAttrs
    recursiveUpdate
    removeAttrs
    ;
  inherit (lib.lists)
    elem
    elemAt
    filter
    flatten
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
    hasInfix
    hasSuffix
    optionalString
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
    replaceImageTag = true;
    pushPostBuild = true;
  };

  utils = rec {
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

    getConvertedToList =
      set: path: convertToList (if hasVal set path then attrByPath path null set else null);

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

    isContainer = name: quadlet: (hasSuffix ".container" name) || (quadlet ? Container);
    isVolume = name: quadlet: (hasSuffix ".volume" name) || (quadlet ? Volume);
    isNetwork = name: quadlet: (hasSuffix ".network" name) || (quadlet ? Network);
    isPod = name: quadlet: (hasSuffix ".pod" name) || (quadlet ? Pod);
    isImage = name: quadlet: (hasSuffix ".image" name) || (quadlet ? Image);
    isBuild = name: quadlet: (hasSuffix ".build" name) || (quadlet ? Build);
    isKube = name: quadlet: (hasSuffix ".kube" name) || (quadlet ? Kube);

    getDependencies =
      qName: qVal:
      let
        networks =
          getConvertedToList qVal [
            "Container"
            "Network"
          ]
          |> filter (net: hasSuffix ".network" net);
        volumes =
          getConvertedToList qVal [
            "Container"
            "Volume"
          ]
          |> filter (vol: hasInfix ".volume" vol)
          |> map (vol: elemAt (splitString ":" vol) 0);
        builds =
          if !cfg.excludeBuildQuadletsFromHosts then
            getConvertedToList qVal [
              "Container"
              "Image"
            ]
            |> filter (img: hasSuffix ".image" img)
          else
            [ ];
      in
      if isContainer qName qVal then networks ++ volumes ++ builds else [ ];
  };

  # Phase 1: Pre-Processors
  # Built-in preprocessors executed in order of `order`.
  # Each preprocessor receives: (name: quadlet: options: utils:) -> modified quadlet
  builtInPreprocessors = {
    basicChecks = {
      order = 0;
      apply =
        name: quadlet: options: utils:
        if utils.isContainer name quadlet && !(quadlet.Container ? ContainerName) then
          throw "Provide Container.ContainerName attribute for ${name}"
        else if utils.isNetwork name quadlet && !(quadlet.Network ? NetworkName) then
          throw "Provide Network.NetworkName attribute for ${name}"
        else if utils.isVolume name quadlet && !(quadlet.Volume ? VolumeName) then
          throw "Provide Volume.VolumeName attribute for ${name}"
        else
          quadlet;
    };

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
                Restart = if utils.isContainer _name quadlet then "always" else "on-failure";
                TimeoutStartSec = 300;
                Type = if utils.isContainer _name quadlet then "notify" else "oneshot";
              };
            }
            // optionalAttrs (utils.isContainer _name quadlet) {
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
        if !(utils.isContainer _name quadlet) || !options.networkNameAlias then
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
          !(utils.isContainer _name quadlet)
          || !options.mapVolumes
          || !(utils.hasVal quadlet [
            "Container"
            "Volume"
          ])
        then
          quadlet
        else
          recursiveUpdate quadlet {
            Container.Volume = map (utils.mapVolume cName) vols;
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
              (utils.isContainer _name quadlet)
              && options.mkdir
              && (utils.hasVal quadlet [
                "Container"
                "Volume"
              ])
            then
              utils.mkdirScript cName vols
            else
              null;
        in
        if !(utils.isContainer _name quadlet) || script == null then
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
            && (utils.hasVal config' [
              "containers"
              cName
              "env"
            ])
          ) config'.containers.${cName}.env;
          existingEnv = utils.convertToList (quadlet.Container.Environment or null);
        in
        if !(utils.isContainer _name quadlet) then
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
          !(utils.isContainer _name quadlet)
          || !options.secretDependency
          || !(utils.hasVal quadlet [
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

    replaceImageTag = {
      enable = cfg.excludeBuildQuadletsFromHosts;
      order = 600;
      apply =
        name: quadlet: options: utils:
        if
          utils.isContainer name quadlet
          && hasSuffix ".build" quadlet.Container.Image
          && options.replaceImageTag
        then
          quadlet
          // {
            Container = quadlet.Container // {
              Image = cfg.quadlets.${quadlet.Container.Image}.Build.ImageTag;
            };
          }
        else if utils.isBuild name quadlet && options.pushPostBuild then
          deepMerge quadlet {
            Service.ExecStartPost = [
              "${osConfig.virtualisation.podman.package}/bin/podman push ${quadlet.Build.ImageTag}"
            ];
          }
        else
          quadlet;
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

  _finalConfig = mapAttrs (
    name: raw:
    let
      options = defaultOptions // (raw.__options or { });
      quadlet = removeAttrs raw [ "__options" ];
      inherit utils;
    in
    pipeline name quadlet options utils
  ) cfg.quadlets;
  finalConfig =
    if cfg.excludeBuildQuadletsFromHosts then
      filterAttrs (n: v: !(v ? Build)) _finalConfig
    else
      _finalConfig;
  finalBuildConfig = filterAttrs (n: v: v ? Build) _finalConfig;

  # Recursively get unit files names for current unit & its own dependencies, if needed.
  unitFilesFor =
    qName: quadlet: recursive:
    let
      unit = unitNameConvertor qName;
      install = quadlet.Install or { };
      dependencies = if recursive then utils.getDependencies qName quadlet else [ ];
      dependencyFiles = map (dep: unitFilesFor dep finalConfig.${dep} recursive) dependencies;
    in
    [ unit ]
    ++ map (t: "${t}.wants/${unit}") (utils.convertToList (install.WantedBy or null))
    ++ map (t: "${t}.requires/${unit}") (utils.convertToList (install.RequiredBy or null))
    ++ map (t: "${t}.upholds/${unit}") (utils.convertToList (install.UpheldBy or null))
    ++ (utils.convertToList (install.Alias or null))
    ++ flatten dependencyFiles;
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
              description = "Function taking `name: quadlet: options: utils:` returning modified quadlet.";
            };
          };
        }
      );
      default = { };
      description = ''
        Customizable pipeline of preprocessing modules executed in order of `order`.
        Built-ins: `basicChecks` (0) `unitDefaults` (100), `networkNameAlias` (150), `mapVolumes` (200), `mkdir` (300), `appendEnv` (400), `secretDependency` (500), replaceImageTag (600).
        Built-in steps can be disabled via `programs.quadlets.preprocessors.<name>.enable = false;`.
      '';
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
      type = types.package;
      readOnly = true;
      description = "Exposed map of all declared .build quadlets and their build specifications.";
    };

    excludeBuildQuadletsFromHosts = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Misleading option name. Below is an explanation with example of what this option achieves:

        For e.g, if two quadlets caddy.container & caddy.build exists, and caddy.container
        refers to caddy.build in Container.Image. That means, that every host using caddy.container
        will try to build caddy.build, which is both time consuming & costly.

        To prevent this, Container.Image (on caddy.container) will be replaced with the Build.ImageTag
        (from caddy.builsd), so that Container.Image always pulls from the Image cache (using the replaceImageTag
        preprocessor). It also adds an ExecStartPost with `podman push` to Build.ImageTag. All the hosts will also
        exclude *.build quadlets, so they don't end up in the final derivation.

        You are responsible for manually building the derivation `programs.quadlets.buildQuadlets` from all
        hosts on CI, and pushing it to the cache given in the Build.ImageTag for the *.build file.
      '';
    };
  };

  config = mkIf cfg.enable (
    let
      # QUADLET_UNIT_DIRS environment stays true to its name.
      writtenQuadlets = mapAttrs (qName: qVal: pkgs.writeTextDir qName (toSystemdUnit qVal)) finalConfig;
      writtenBuildQuadlets = mapAttrs (
        qName: qVal: pkgs.writeTextDir qName (toSystemdUnit qVal)
      ) finalBuildConfig;

      # The debug check recursively checks for the current unit,
      # its dependencies, and so on.
      convertQuadletToUnits =
        finalQuadletAttrs: writtenFiles:
        mapAttrs (
          qName: qVal:
          let
            quadletDeps = map (dep: toString writtenFiles.${dep}) (utils.getDependencies qName qVal);
            recursiveExpectedUnits = unitFilesFor qName qVal true;
          in
          pkgs.runCommand "quadlet-build-${qName}" { } ''
            mkdir -p $out
            QUADLET_UNIT_DIRS="${writtenFiles.${qName}}${
              optionalString (quadletDeps != [ ]) ":${concatStringsSep ":" quadletDeps}"
            }" ${osConfig.virtualisation.podman.package}/libexec/podman/quadlet -v -user $out

            (
              cd $out
              for file in $(find . -type f | sed 's|^\./||'); do
                substituteInPlace "$file" \
                  --replace-quiet ${writtenFiles.${qName}}/\$\{XDG_RUNTIME_DIR} \$\{XDG_RUNTIME_DIR} \
                  --replace-quiet \\x20 " "
              done
            )

            expected=${escapeShellArg (concatStringsSep "\n" recursiveExpectedUnits)}
            while IFS= read -r f; do
              if ! grep -qxF -- "$f" <<< "$expected"; then
                echo "[quadlet-generator] unexpected generator output: $f" >&2
                exit 1
              fi
            done < <(cd $out && find . \( -type f -o -type l \) | sed 's|^\./||' | sort)
          ''
        ) finalQuadletAttrs;
    in
    {
      programs.quadlets.preprocessors = builtInPreprocessors;
      programs.quadlets.buildQuadlets = pkgs.symlinkJoin {
        name = "quadlet-units";
        paths = attrValues (convertQuadletToUnits finalBuildConfig writtenBuildQuadlets);
      };

      # Phase 3: Final linking
      # Here, only units belonging to its own respective quadlet are linked.
      # This is unlike the check above, since we want to avoid collisions, due to
      # different parameter ordering in ExecStart=.
      xdg.configFile = foldl' (acc: elem: acc // elem) { } (
        mapAttrsToList (
          qName: outDir:
          let
            quadletUnitNames = unitFilesFor qName finalConfig.${qName} false;
            quadletUnitsMapped = listToAttrs (
              map (svc: nameValuePair "systemd/user/${svc}" { source = "${outDir}/${svc}"; }) quadletUnitNames
            );
          in
          quadletUnitsMapped
        ) (convertQuadletToUnits finalConfig writtenQuadlets)
      );
    }
  );
}
