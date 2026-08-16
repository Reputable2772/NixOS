{
  config,
  pkgs,
  lib',
  lib,
  ...
}:
let
  toml = pkgs.formats.toml { };
  cfg = config.secretspec;

  inherit (lib) types;
  inherit (lib.attrsets)
    attrNames
    attrValues
    mapAttrs
    ;
  inherit (lib.lists) filter;
  inherit (lib.options) mkOption mkPackageOption;
  inherit (lib.strings) concatMapStringsSep optionalString;

  paths = rec {
    base = "/run/secrets";
    generation = "/run/secrets.d";
    profiles = "${base}/profiles";
    scopes = "${base}/scopes";
    individual = "${base}/individual";
  };

  userConfig = if cfg.file == null then cfg.config else fromTOML (builtins.readFile cfg.file);
  configFile = if cfg.file == null then toml.generate "secretspec.toml" userConfig else cfg.file;
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
in
{
  options.secretspec = {
    config = mkOption {
      description = ''
        secretspec.toml config in Nix.

        **IMPORTANT: Relative Paths**
        If you specify a relative path for an Age provider (e.g., `age://Config/Secrets/wickedwizard.age`),
        it MUST be strictly relative to the `flakeRootDir`.
        During decryption, the service copies the entire Nix configuration root into a temporary workspace
        to accurately resolve these relative paths.

        Make sure the age files are checked into git.
      '';
      type = toml.type;
      default = { };
    };

    file = mkOption {
      description = "Path to secretspec.toml file.";
      type = types.nullOr types.path;
      default = null;
    };

    flakeRootDir = mkOption {
      description = ''
        Path to the root directory of your Nix configuration
        (e.g., `./.`). This is copied into the runtime workspace
        to resolve relative provider paths.
      '';
      type = types.path;
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
      description = "Final secretspec.toml outpath.";
      default = configFile;
    };
  };

  config = lib.mkIf (profiles != { }) {
    assertions = [
      {
        assertion = !(cfg.file != null && cfg.config != { });
        message = "Set only one of secretspec.config or secretspec.file";
      }
      {
        assertion = (filter (profile: profile.path or false) (attrValues profiles)) == [ ];
        message = "A secret cannot be named 'path'.";
      }
    ];

    environment.systemPackages = [ cfg.package ];

    system.activationScripts.secretspec = {
      deps = [ "specialfs" ];
      text = ''
        set -euo pipefail

        baseDir="${paths.base}"
        generationsDir="${paths.generation}"
        mkdir -p "$generationsDir"

        generationDir="$(mktemp -d "$generationsDir/generation.XXXXXXXX")"
        profilesDir="$generationDir/profiles"
        scopesDir="$generationDir/scopes"
        individualDir="$generationDir/individual"

        mkdir -p "$profilesDir" "$scopesDir" "$individualDir"

        workDir="$(mktemp -d)"
        trap 'rm -rf -- "$workDir" "$generationDir"' EXIT

        chmod 0700 "$workDir"
        chmod 0700 "$generationDir"

        # NixOS config root is copied into the temporary workspace so relative provider paths resolve perfectly.
        cp -a --no-preserve=mode ${cfg.flakeRootDir}/* "$workDir"

        # Copy the generated TOML as the default name so the CLI finds it automatically.
        cp --no-preserve=mode ${configFile} "$workDir/secretspec.toml"

        cd "$workDir"

        ${concatMapStringsSep "\n" (profile: ''
          echo "[secretspec] Decrypting profile: ${profile}"
          ${lib.getExe cfg.package} export \
            --profile "${profile}" \
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
            echo "[secretspec] Decrypting scope: ${scope} (profile: ${profile})"

            ${lib.getExe cfg.package} export \
              --scope "${scope}" \
              --profile "${profile}" \
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

        oldGeneration="$(readlink "$baseDir" || true)"

        if [ -e "$baseDir" ] || [ -L "$baseDir" ]; then
          if [ ! -L "$baseDir" ]; then
            rm -rf -- "$baseDir"
          fi
        fi

        ln -sfnT -- "$generationDir" "''${baseDir}.new"
        mv -Tf -- "''${baseDir}.new" "$baseDir"

        echo "[secretspec] Secrets activated successfully"

        trap 'rm -rf -- "$workDir"' EXIT
      '';
    };
  };
}
