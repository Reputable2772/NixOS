{ config, lib, pkgs, ... }:

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
          "tmp=$(echo $out/source)"
        ]
        ++ (map
          (_:
            let
              inherit (_) name content;
            in
            ''
              cat <<_EOF >$tmp/${name}
              ${content}
              _EOF
            '')
          cfg.quadlets)
        ++ [
          "QUADLET_UNIT_DIRS=$tmp/ ${pkgs.podman}/libexec/podman/quadlet $out/units"
        ];
    in
    lib.mkIf cfg.enable {
      xdg.configFile."systemd/user/" = {
        source = "${pkgs.runCommand "quadlet-generator" { } (concatStringsSep "\n" contents)}/units";
        recursive = true;
      };
    };
}

