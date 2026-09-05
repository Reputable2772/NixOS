{
  config',
  pkgs,
  lib',
  lib,
  extraArgs ? {
    paths = {
      base = "";
      generation = "";
    };
    system = false;
  },
  ...
}:
let
  toml = pkgs.formats.toml { };
  cfg = config'.secretspec;

  inherit (lib) assertMsg getExe types;
  inherit (lib.attrsets)
    attrNames
    attrValues
    mapAttrs
    optionalAttrs
    ;
  inherit (lib.lists) filter;
  inherit (lib.modules) mkAfter mkMerge mkRenamedOptionModule;
  inherit (lib.options) mkOption mkPackageOption;
  inherit (lib.strings)
    concatMapAttrsStringSep
    concatMapStringsSep
    concatStringsSep
    hasInfix
    isPath
    replaceStrings
    ;

  paths = rec {
    inherit (extraArgs.paths) base generation;
    profiles = "${base}/profiles";
    scopes = "${base}/scopes";
    individual = "${base}/individual";
  };

  userConfig = if isPath cfg.config then fromTOML (builtins.readFile cfg.config) else cfg.config;
  configFile = if isPath cfg.config then cfg.config else toml.generate "secretspec.toml" userConfig;

  profiles = userConfig.profiles or { };
  scopes = userConfig.scopes or { };

  mappedProfiles =
    lib'.mapAttrsTreeDepth
      (
        depth: n: v:
        v
      )
      (
        depth: secretName: secretVal:
        if secretName == "defaults" then
          secretVal
        else
          secretVal
          // (
            if depth == 1 then
              { path = "${paths.profiles}/${secretName}"; }
            else
              {
                envPath = "${paths.individual}/${secretName}.env";
                plainPath = "${paths.individual}/${secretName}";
              }
          )
      )
      2
      profiles;
  mappedScopes = mapAttrs (
    scopeName: scopeVal: scopeVal // { path = "${paths.scopes}/${scopeName}"; }
  ) scopes;

  /**
    This is needed to point secretspec.toml to the correct age
    files in the nix store. Do not set this for secretspec.configFile.
    That option is meant for adding/removing secrets using secretspec cli

    NOTE: only *public* material (encrypted blobs, recipient files) should
    ever go through cfg.providerFiles. Never route a private age identity through
    here - cfg.providerFiles values land in the Nix store, which is world-readable.
  */
  runtimeProviders = mapAttrs (
    name: val:
    if (cfg.providerFiles ? ${name}) then
      let
        keys = attrNames cfg.providerFiles.${name};
        missing = filter (k: !(hasInfix k val)) keys;
      in
      assert assertMsg (missing == [ ])
        "secretspec: provider '${name}' URI does not contain expected placeholder(s): ${concatStringsSep ", " missing}. Got: ${val}";
      replaceStrings keys (map (v: toString v) (attrValues cfg.providerFiles.${name})) val
    else
      val
  ) (userConfig.providers or { });
  runtimeUserConfig = userConfig // {
    providers = runtimeProviders;
  };
  runtimeConfigFile = toml.generate "secretspec.toml" runtimeUserConfig;

  # Activation-time check + decrypt. Runs post-build, outside the sandbox,
  # as the real user with real $HOME - this is where the private identity
  # actually resolves, so this is where `secretspec check` belongs.
  activationScript = ''
    baseDir="${paths.base}"
    generationsDir="${paths.generation}"
    mkdir -p "$generationsDir"

    generationDir="$(mktemp -d "$generationsDir/generation.XXXXXXXX")"
    profilesDir="$generationDir/profiles"
    scopesDir="$generationDir/scopes"
    individualDir="$generationDir/individual"

    mkdir -p "$profilesDir" "$scopesDir" "$individualDir"

    trap 'rm -rf -- "$generationDir"' EXIT

    chmod 0700 "$generationDir"

    check_failed=0

    ${concatMapStringsSep "\n" (profile: ''
      echo "[secretspec] Checking profile: ${profile}"

      if ! ${getExe cfg.package} check \
        --file ${runtimeConfigFile} \
        --profile ${profile} \
        --reason "Activation Time - Profile Check"
      then
        echo "[secretspec] Check failed for profile: ${profile}"
        check_failed=1
      fi
    '') (attrNames profiles)}

    if [ "$check_failed" -ne 0 ]; then
      echo "[secretspec] Secret checks failed; refusing to activate secrets"

      # Cleanup trap & exit
      trap - EXIT
      rm -rf -- "$generationDir"
    else
      ${concatMapStringsSep "\n" (profile: ''
        echo "[secretspec] Decrypting profile: ${profile}"
        ${getExe cfg.package} export \
          --file ${runtimeConfigFile} \
          --profile ${profile} \
          --reason "Secret Decryption - Profile" \
          --format json |
          ${getExe pkgs.jq} -r 'to_entries[] | "\(.key)=\(.value)"' \
          > "$profilesDir/${profile}"

        chmod 0400 "$profilesDir/${profile}"
      '') (attrNames profiles)}

      # Since we don't know which scope belongs to which profile,
      # we export and run it for all profiles.
      # Total time = scopes x profiles.
      ${concatMapStringsSep "\n" (scope: ''
        ${concatMapStringsSep "\n" (profile: ''
          echo "[secretspec] Decrypting profile, scope: ${profile}, ${scope}"
          ${getExe cfg.package} export \
            --file ${runtimeConfigFile} \
            --scope ${scope} \
            --profile ${profile} \
            --reason "Secret Decryption - Scope" \
            --format json |
            ${getExe pkgs.jq} -r 'to_entries[] | "\(.key)=\(.value)"' \
            >> "$scopesDir/${scope}"

          chmod 0400 "$scopesDir/${scope}"
        '') (attrNames profiles)}
      '') (attrNames scopes)}

      ${concatMapStringsSep "\n" (
        profile:
        let
          secrets = filter (secret: secret != "defaults") (attrNames profiles.${profile});
        in
        concatMapStringsSep "\n" (secret: ''
          echo "[secretspec] Decrypting secret: ${secret} (profile: ${profile})"

          secret_val=$(
            ${getExe cfg.package} get \
              --file ${runtimeConfigFile} \
              --reason "Individual Secrets access" \
              --profile "${profile}" \
              "${secret}"
          )

          printf '%s' "$secret_val" > "$individualDir/${secret}"
          printf '%s=%s\n' "${secret}" "$secret_val" > "$individualDir/${secret}.env"

          chmod 0400 "$individualDir/${secret}"
          chmod 0400 "$individualDir/${secret}.env"
        '') secrets
      ) (attrNames profiles)}

      echo "[secretspec] Activating secrets"

      # If it's not a symlink, then remove it.
      if [ -e "$baseDir" ] || [ -L "$baseDir" ]; then
        if [ ! -L "$baseDir" ]; then
          rm -rf -- "$baseDir"
        fi
      fi

      oldGeneration="$(readlink -f "$baseDir" 2>/dev/null || true)"

      ln -sfnT -- "$generationDir" "''${baseDir}.new"
      mv -Tf -- "''${baseDir}.new" "$baseDir"

      # Don't cleanup live generation
      trap - EXIT

      echo "[secretspec] Secrets activated successfully"

      if [ -n "$oldGeneration" ] && [ "$oldGeneration" != "$generationDir" ] && [ "$oldGeneration" != "$baseDir" ]; then
        rm -rf -- "$oldGeneration"
      fi
      echo "[secretspec] Cleared previous generations"
    fi
  '';

  replacePythonScript = pkgs.writeText "replace-script" ''
    import pathlib
    import sys

    source = pathlib.Path(sys.argv[1])
    target = pathlib.Path(sys.argv[2])

    text = source.read_text()

    for i in range(3, len(sys.argv), 2):
      placeholder = sys.argv[i]
      secret_path = pathlib.Path(sys.argv[i + 1])
      text = text.replace(placeholder, secret_path.read_text())

    target.write_text(text)
  '';
in
{
  options.secretspec = {
    config = mkOption {
      description = ''
        secretspec.toml configuration. This can be specified either as
        an inline Nix value or as a path to a secretspec.toml file.
        Paths are resolved and stored in the Nix store.
      '';
      type = types.oneOf [
        toml.type
        types.path
      ];
      default = { };
    };

    providerFiles = mkOption {
      description = ''
        Public files referenced by providers in secretspec.toml (e.g. age
        encrypted blobs, recipient/public-key files). This is an attrset
        mapping each provider path to the corresponding file path. Files
        must be checked into the flake's source tree.

        For example, if secretspec.toml contains a provider at
        "age://Config/Secrets/test.age", with name "age", and the corresponding age file is
        located at Config/Secrets/test.age relative to the flake root, specify:

          {
            age."Config/Secrets/test.age" = ../../Config/Secrets/test.age;
          }
      '';
      type = types.attrsOf (types.attrsOf types.path);
      default = { };
    };

    package = mkPackageOption pkgs "secretspec" { };

    secrets = mkOption {
      description = "Final attrset containing the out path of each secret.";
      default = {
        profiles = mappedProfiles;
        scopes = mappedScopes;
      };
      type = types.attrs;
      readOnly = true;
    };

    configFile = mkOption {
      description = ''
        secretspec.toml file derivation.

        It can be built independently, if config
        is specified inline, and secretspec.toml is required
        to set secrets.
      '';
      default = configFile;
    };

    runtimeConfigFile = mkOption {
      description = ''
        secretspec.toml file derivation.

        This is the one used by secretspec.toml
        internally during activation. It is mainly
        meant for inspection, and not setting/deleting
        secrets. Use secretspec.configFile for those
        purposes.
      '';
      default = runtimeConfigFile;
    };

    runtimeSecretReplacementFunc = mkOption {
      description = ''
        For a file in ~/.config/xx/yy.json, yy.json needs to be
        declarative, except for values which are secrets.
        Storing the entire file in secretspec as a secret isn't ideal.

        To remedy this, this option exists as a function.
        For any file, set its onChange attribute to:
          secretspec.runtimeSecretReplacementFunc "FILE_PATH" {
            "PLACEHOLDER_1" = config.secretspec.secrets.profiles.test.secret;
            "PLACEHOLDER_2" = config.secretspec.secrets.profiles.test.otherSecret;
          }

        where the attribute names are placeholders inside the file and
        the values are paths to the corresponding runtime secret files.
      '';
      type = types.functionTo (types.functionTo types.str);
      default =
        path: replacers:
        let
          args = concatMapAttrsStringSep " " (
            substitute: secret: "${substitute} ${secret.plainPath}"
          ) replacers;
        in
        ''
          current_file=${path}
          tmp="$(mktemp)"

          ${pkgs.python3}/bin/python3 ${replacePythonScript} "$current_file" "$tmp" ${args}

          mv "$tmp" "$current_file"
        '';
    };
  };

  imports = [
    (mkRenamedOptionModule [ "secretspec" "files" ] [ "secretspec" "providerFiles" ])
  ];

  config = mkMerge [
    {
      assertions = [
        {
          assertion = (filter (profile: profile.path or false) (attrValues profiles)) == [ ];
          message = "A secret cannot be named 'path'.";
        }
      ];
    }

    (optionalAttrs extraArgs.system {
      environment.systemPackages = [ cfg.package ];

      system.activationScripts = {
        users.deps = mkAfter [ "secretspec" ];
        secretspec = {
          deps = [ "specialfs" ];
          text = activationScript;
        };
      };
    })

    (optionalAttrs (!extraArgs.system) {
      home.packages = [ cfg.package ];

      # this is so we can reliably run reloadSystemd,
      # refresh secrets, and then run the runtime file
      # hook
      home.activation.secretspec = lib.hm.dag.entryBetween [ "onFilesChange" ] [ "reloadSystemd" ] "";

      systemd.user.services.secretspec = {
        Install.WantedBy = [ "default.target" ];
        Unit.X-Restart-Triggers = [ runtimeConfigFile ];
        Service = {
          Type = "oneshot";
          RemainAfterExit = true;
          RuntimeDirectory = "secretspec";
          WorkingDirectory = "%t/secretspec";
          ExecStart = pkgs.writeShellScript "secretspec-decryption" activationScript;
        };
      };
    })
  ];
}
