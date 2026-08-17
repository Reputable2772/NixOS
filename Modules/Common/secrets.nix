# TODO: Secret Validation before activation, maybe using runCommand?
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

  inherit (lib) types;
  inherit (lib.attrsets)
    attrNames
    attrValues
    mapAttrs
    ;
  inherit (lib.lists) filter;
  inherit (lib.modules) mkMerge;
  inherit (lib.options) mkOption mkPackageOption;
  inherit (lib.strings)
    concatMapStringsSep
    isPath
    optionalString
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
      (if cfg.separateSecrets then 2 else 1)
      profiles;
  mappedScopes = mapAttrs (
    scopeName: scopeVal: scopeVal // { path = "${paths.scopes}/${scopeName}"; }
  ) scopes;
  # This is needed to point secretspec.toml to the correct age
  # files in the nix store.
  replacedProviders = mapAttrs (
    name: val:
    if (cfg.files ? ${name}) then
      replaceStrings (attrNames cfg.files.${name}) (map (v: toString v) (
        attrValues cfg.files.${name}
      )) val
    else
      val
  ) (userConfig.providers or { });
  replacedUserConfig = userConfig // {
    providers = replacedProviders;
  };
  replacedConfigFile = toml.generate "secretspec.toml" replacedUserConfig;
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

    ${concatMapStringsSep "\n" (profile: ''
      echo "Decrypting profile - ${profile}"
      ${lib.getExe cfg.package} export \
        --file ${replacedConfigFile} \
        --profile ${profile} \
        --reason "Secret Decryption - Profile" \
        --format json |
        ${lib.getExe pkgs.jq} -r 'to_entries[] | "\(.key)=\(.value)"' \
        > "$profilesDir/${profile}"

      chmod 0400 "$profilesDir/${profile}"
    '') (attrNames profiles)}

    # Since we don't know which scope belongs to which profile,
    # we export and run it for all profiles.
    # Total time = scopes x profiles.
    ${concatMapStringsSep "\n" (scope: ''
      ${concatMapStringsSep "\n" (profile: ''
        echo "Decrypting profile, scope - ${profile}, ${scope}"
        ${lib.getExe cfg.package} export \
          --file ${replacedConfigFile} \
          --scope ${scope} \
          --profile ${profile} \
          --reason "Secret Decryption - Scope" \
          --format json |
          ${lib.getExe pkgs.jq} -r 'to_entries[] | "\(.key)=\(.value)"' \
          > "$scopesDir/${scope}"

        chmod 0400 "$scopesDir/${scope}"
      '') (attrNames profiles)}
    '') (attrNames scopes)}

    ${optionalString cfg.separateSecrets ''
      echo "[secretspec] Decrypting individual secrets"

      ${concatMapStringsSep "\n" (
        profile:
        let
          secrets = filter (secret: secret != "defaults") (attrNames profiles.${profile});
        in
        concatMapStringsSep "\n" (secret: ''
          echo "[secretspec] Decrypting secret: ${secret} (profile: ${profile})"

          secret_val=$(
            ${lib.getExe cfg.package} get \
              --file ${replacedConfigFile} \
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
    ''}

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

    files = mkOption {
      description = ''
        Age files referenced by providers in secretspec.toml.

        This is an attrset mapping each provider path to the corresponding
        age file path. The age files must be checked into the flake's source
        tree.

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

    separateSecrets = mkOption {
      description = ''
        Each secret has a different file for itself, exported as
        dotenv & plaintext files.
      '';
      default = true;
      type = types.bool;
    };

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
  };

  config = mkMerge [
    {
      assertions = [
        {
          assertion = (filter (profile: profile.path or false) (attrValues profiles)) == [ ];
          message = "A secret cannot be named 'path'.";
        }
      ];
    }

    (lib.optionalAttrs extraArgs.system {
      environment.systemPackages = [ cfg.package ];

      system.activationScripts = {
        users.deps = lib.mkAfter [ "secretspec" ];
        secretspec = {
          deps = [ "specialfs" ];
          text = activationScript;
        };
      };
    })

    (lib.optionalAttrs (!extraArgs.system) {
      home.packages = [ cfg.package ];

      systemd.user.services.secretspec = {
        Install.WantedBy = [ "default.target" ];
        Unit.X-Restart-Triggers = [ replacedConfigFile ];
        Service = {
          Type = "oneshot";
          RuntimeDirectory = "secretspec";
          WorkingDirectory = "%t/secretspec";
          ExecStart = pkgs.writeShellScript "secretspec-decryption" activationScript;
        };
      };
    })
  ];
}
