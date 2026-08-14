{
  config,
  pkgs,
  lib,
  ...
}:
let
  toml = pkgs.formats.toml { };
  cfg = config.secretspec;

  inherit (lib) types;
  inherit (lib.attrsets) attrNames attrValues removeAttrs;
  inherit (lib.lists) filter map;
  inherit (lib.options) mkOption mkPackageOption;
  inherit (lib.strings) concatMapStringsSep optionalString;

  profiles = cfg.finalConfig.profiles or { };
  scopes = cfg.finalConfig.scopes or { };
  # secrets = map (prof: removeAttrs prof [ "defaults" ]) (attrValues profiles);
in
{
  options.secretspec = {
    config = mkOption {
      description = "secretspec.toml config in Nix";
      type = toml.type;
      default = { };
    };

    file = mkOption {
      description = "Path to secretspec.toml file.";
      type = types.nullOr types.path;
      default = null;
    };

    finalConfig = mkOption {
      description = "secretspec.toml config file";
      default = if cfg.file == null then cfg.config else fromTOML (builtins.readFile cfg.file);
      readOnly = true;
    };

    separateSecrets = mkOption {
      description = "Each secret has a different file for itself, exported as dotenv & plaintext files.";
      default = true;
      type = types.bool;
    };

    configFile = mkOption {
      description = "secretspec.toml config file derivation";
      default = if cfg.file == null then (toml.generate "secretspec.toml" cfg.finalConfig) else cfg.file;
      readOnly = true;
    };

    package = mkPackageOption pkgs "secretspec" { };
  };

  config = lib.mkIf (profiles != { }) {
    assertions = [
      {
        assertion = !(cfg.file != null && cfg.config != { });
        message = "Set only one of secrets.config or secrets.file";
      }
    ];

    home.packages = [ cfg.package ];

    systemd.user.services.secretspec = {
      Install.WantedBy = [ "default.target" ];

      Service = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "secretspec-decryption" ''
          baseDir="/run/user/$(id -u)/secrets"
          profilesDir="$baseDir/profiles"
          scopesDir="$baseDir/scopes"
          individualDir="$baseDir/individual"

          rm -rf $baseDir
          mkdir -p $baseDir $profilesDir $scopesDir $individualDir

          ${concatMapStringsSep "\n" (profile: ''
            echo "Decrypting profile - ${profile}"
            ${lib.getExe cfg.package} export --file ${cfg.configFile} --profile ${profile} --reason "Secret Decryption - Profile" --format dotenv > $profilesDir/${profile}
          '') (attrNames profiles)}

          # Since we don't know which scope belongs to which profile,
          # we export and run it for all profiles.
          # Total time = scopes x profiles.
          ${concatMapStringsSep "\n" (scope: ''
            ${concatMapStringsSep "\n" (profile: ''
              echo "Decrypting profile, scope - ${profile}, ${scope}"
                ${lib.getExe cfg.package} export --file ${cfg.configFile} --scope ${scope} --profile ${profile} --reason "Secret Decryption - Scope" --format dotenv >> $scopesDir/${scope}
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
                ${lib.getExe cfg.package} get --file ${cfg.configFile} --profile ${profile} ${secret} > $individualDir/${secret}
                echo "${secret}=$(${lib.getExe cfg.package} get --file ${cfg.configFile} --profile ${profile} ${secret})" > $individualDir/${secret}.env
              '') secrets
            ) (attrNames profiles)}
          ''}
        '';
      };
    };
  };
}
