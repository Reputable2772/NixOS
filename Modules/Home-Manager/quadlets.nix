{ osConfig, config, lib, pkgs, ... }:

let
  inherit (lib) types;
  inherit (lib.lists) map;
  inherit (lib.options) literalExpression mkEnableOption mkOption;
  inherit (lib.strings) concatStringsSep;
  cfg = config.programs.quadlets;
  quadletType = types.submodule
    ({ config, ... }: {
      options = {
        name = mkOption {
          type = types.str;
          description = ''
            Name of quadlet file.

            Example:
            caddy.network, caddy.container, vaultwarden.container, etc.
          '';
        };
        content = mkOption {
          type = types.str;
          description = ''
            Contents of quadlet file.
          '';
        };
      };
    });
in
{
  options.programs.quadlets = {
    enable = mkEnableOption "Podman's Quadlets";
    quadlets = mkOption {
      default = [ ];
      example = literalExpression "[ ''Quadlet file here'' ]";
      type = types.listOf quadletType;
      description = "All the quadlet files that need to have systemd unit files generated";
    };
  };

  config =
    let
      contents =
        [
          "mkdir -p $out $out/source $out/units"
        ]
        ++ (map
          (_:
            let
              file = pkgs.writeTextDir _.name _.content;
            in
            ''
              cp ${file}/* $out/source
              QUADLET_UNIT_DIRS=${file} ${osConfig.virtualisation.podman.package}/libexec/podman/quadlet -user $out/units

              for file in $(find $out/units -type f -exec realpath --relative-to $out/units {} \;); do
                # We do this so that podman doesn't resolve the paths relative to the QUADLET_UNIT_DIRS (why, podman, why?)
                # and also because replacing $XDG_RUNTIME_DIR with $\{XDG_RUNTIME_DIR} really fixes Podman's environment variable resolution.
                substituteInPlace $out/units/$file \
                  --replace-warn ${file}/\$XDG_RUNTIME_DIR \$\{XDG_RUNTIME_DIR}
              done
            '')
          cfg.quadlets);
    in
    lib.mkIf cfg.enable {
      xdg.configFile."systemd/user/" = {
        source = "${pkgs.runCommand "quadlet-generator" { } (concatStringsSep "\n" contents)}/units";
        recursive = true;
      };
    };
}

