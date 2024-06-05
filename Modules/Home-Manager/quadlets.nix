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
        ]
        ++ (map
          (_:
            let
              file = pkgs.writeTextDir _.name _.content;
            in
            ''
              cp ${file}/* $out/source
              QUADLET_UNIT_DIRS=${file} ${pkgs.podman}/libexec/podman/quadlet $out/units
            '')
          cfg.quadlets);
    in
    lib.mkIf cfg.enable {
      xdg.configFile."systemd/user/" = {
        source = "${pkgs.runCommand "quadlet-generator" { } (concatStringsSep "\n" contents)}/units";
        recursive = true;
      };

      /**
        Solves this issue.
        https://matrix.to/#/!RRerllqmbATpmbJgCn:nixos.org/$kZUAN0U0ydYnQOu5Ho2GFWALq20fH1Kd-gqodksK59M?via=nixos.org&via=matrix.org&via=tchncs.de

        No clue as to why this issue occurs, but this is necessary for the Quadlets to run, since I cannot use an systemd.user.services.<name>.overrideStrategy for them,
        therefore requiring this workaround. This also fixes the gocryptfs service (no need to set PATH in Environment), but that can stay.
       */
      systemd.user.settings.Manager.DefaultEnvironment.PATH = "/run/wrappers/bin:$PATH";
      systemd.user.settings.Manager.ManagerEnvironment.PATH = "/run/wrappers/bin:$PATH";
    };
}

