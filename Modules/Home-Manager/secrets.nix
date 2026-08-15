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
    base = "\${XDG_RUNTIME_DIR}/secrets";
    profiles = "${base}/profiles";
    scopes = "${base}/scopes";
    individual = "${base}/individual";
  };

  userConfig = if cfg.file == null then cfg.config else fromTOML (builtins.readFile cfg.file);
  configFile = if cfg.file == null then (toml.generate "secretspec.toml" userConfig) else cfg.file;
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
      description = "Path to the root directory of your Nix configuration (e.g., `./.`). This is copied into the runtime workspace to resolve relative provider paths.";
      type = types.path;
    };

    package = mkPackageOption pkgs "secretspec" { };

    separateSecrets = mkOption {
      description = "Each secret has a different file for itself, exported as dotenv & plaintext files.";
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
        message = "Set only one of secrets.config or secrets.file";
      }
      {
        assertion = (filter (profile: profile.path or false) (attrValues profiles)) == [ ];
        message = "A secret cannot be named 'path'.";
      }
    ];

    home.packages = [ cfg.package ];

    systemd.user.services.secretspec = {
      Install.WantedBy = [ "default.target" ];

      Service = {
        Type = "oneshot";
        RuntimeDirectory = "secretspec";
        WorkingDirectory = "%t/secretspec";
        ExecStart = pkgs.writeShellScript "secretspec-decryption" ''
          set -euo pipefail

          # NixOS config root is copied into the temporary workspace so relative provider paths resolve perfectly.
          cp -r --no-preserve=mode ${cfg.flakeRootDir}/* .

          # Copy the generated TOML as the default name so the CLI finds it automatically.
          cp --no-preserve=mode ${configFile} ./secretspec.toml

          baseDir="${paths.base}"
          profilesDir="${paths.profiles}"
          scopesDir="${paths.scopes}"
          individualDir="${paths.individual}"

          rm -rf $baseDir
          mkdir -p $baseDir $profilesDir $scopesDir $individualDir

          ${concatMapStringsSep "\n" (profile: ''
            echo "Decrypting profile - ${profile}"
            ${lib.getExe cfg.package} export --profile ${profile} --reason "Secret Decryption - Profile" --format dotenv > $profilesDir/${profile}
          '') (attrNames profiles)}

          # Since we don't know which scope belongs to which profile,
          # we export and run it for all profiles.
          # Total time = scopes x profiles.
          ${concatMapStringsSep "\n" (scope: ''
            ${concatMapStringsSep "\n" (profile: ''
              echo "Decrypting profile, scope - ${profile}, ${scope}"
                ${lib.getExe cfg.package} export --scope ${scope} --profile ${profile} --reason "Secret Decryption - Scope" --format dotenv >> $scopesDir/${scope}
            '') (attrNames profiles)}
          '') (attrNames scopes)}

          ${optionalString cfg.separateSecrets ''
            echo "Decrypting secrets individually"

            ${concatMapStringsSep "\n" (
              profile:
              let
                secrets = filter (prof: prof != "defaults") (attrNames profiles.${profile});
              in
              concatMapStringsSep "\n" (secret: ''
                secret_val=$(${lib.getExe cfg.package} get --profile ${profile} ${secret})
                echo "$secret_val" > $individualDir/${secret}
                echo "${secret}=$secret_val" > $individualDir/${secret}.env
              '') secrets
            ) (attrNames profiles)}
          ''}
        '';
      };
    };
  };
}
