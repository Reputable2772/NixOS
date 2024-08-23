{ osConfig, config, pkgs, lib, lib', ... }:

let
  inherit (lib) types;
  inherit (lib.attrsets) hasAttrByPath mapAttrsToList optionalAttrs recursiveUpdate;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.strings) concatMapStringsSep concatStringsSep;

  cfg = config.programs.quadlets;
in
{
  options.programs.quadlets = {
    enable = mkEnableOption "Podman's Quadlets";
    mkdir = mkEnableOption "Creating directories if they don't exist.";
    quadlets = mkOption {
      default = { };
      type = with types;
        let primitive = oneOf [ bool int str path ];
        in attrsOf (attrsOf (attrsOf (either primitive (listOf primitive)))) // {
          description = "Quadlet configuration.";
        };
      description = "All the quadlets that need to have systemd unit files generated";
    };
  };

  config =
    let
      contents =
        [
          "mkdir -p $out $out/source $out/units"
        ]
        ++ (mapAttrsToList
          (n: v:
            let
              # Don't override if a user already set ExecStartPre
              val = recursiveUpdate
                (optionalAttrs (cfg.mkdir && hasAttrByPath [ "Container" "Volume" ] v && (v.Container.Volume != null || v.Container.Volume != [ ])) {
                  Service.ExecStartPre = pkgs.writeShellScript "${n}-mkdir" (concatMapStringsSep "\n" (x: "${pkgs.coreutils}/bin/mkdir -p ${builtins.elemAt (builtins.split ":" x) 0}") v.Container.Volume);
                })
                v;
              file = pkgs.writeTextDir n (lib'.toSystemdUnit val);
            in
            ''
              cp ${file}/* $out/source
              QUADLET_UNIT_DIRS=${file} ${osConfig.virtualisation.podman.package}/libexec/podman/quadlet -user $out/units

              for file in $(find $out/units -type f -exec realpath --relative-to $out/units {} \;); do
                substituteInPlace $out/units/$file \
                  --replace-warn ${file}/\$\{XDG_RUNTIME_DIR} \$\{XDG_RUNTIME_DIR}
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

