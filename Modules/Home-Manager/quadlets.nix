{ osConfig, config, pkgs, lib, lib', ... }:

let
  inherit (lib) types;
  inherit (lib.attrsets) mapAttrsToList;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.strings) concatStringsSep;

  cfg = config.programs.quadlets;
in
{
  options.programs.quadlets = {
    enable = mkEnableOption "Podman's Quadlets";
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
              file = pkgs.writeTextDir n (lib'.toSystemdUnit v);
            in
            ''
              cp ${file}/* $out/source
              QUADLET_UNIT_DIRS=${file} ${osConfig.virtualisation.podman.package}/libexec/podman/quadlet -user $out/units

              for file in $(find $out/units -type f -exec realpath --relative-to $out/units {} \;); do
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

