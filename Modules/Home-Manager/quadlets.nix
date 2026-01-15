{
  osConfig,
  config,
  pkgs,
  lib,
  lib',
  ...
}:

let
  inherit (lib) types;
  inherit (lib.attrsets)
    attrNames
    hasAttrByPath
    mapAttrsToList
    optionalAttrs
    ;
  inherit (lib.lists) filter map optional;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.strings) concatMapStringsSep hasSuffix replaceStrings;

  cfg = config.programs.quadlets;

  quadlets = pkgs.buildEnv {
    name = "quadlets";
    paths = mapAttrsToList (
      n: v:
      let
        # Merge mkdir script and pre-defined ExecStartPre
        val = lib'.deepMerge (optionalAttrs
          (
            cfg.mkdir
            && hasAttrByPath [
              "Container"
              "Volume"
            ] v
            && (v.Container.Volume != null || v.Container.Volume != [ ])
          )
          {
            Service.ExecStartPre = [
              # (pkgs.writeShellScript "${n}-mkdir" (
              #   concatMapStringsSep "\n" (
              #     x: "${pkgs.coreutils}/bin/mkdir -p ${builtins.elemAt (builtins.split ":" x) 0}"
              #   ) v.Container.Volume
              # ))
              (
                v.Container.Volume
                |> map (x: builtins.elemAt (builtins.split ":" x) 0)
                |> filter (x: !(hasSuffix ".volume" x))
                |> concatMapStringsSep "\n" (x: "[[ ! -e ${x} ]] && ${pkgs.coreutils}/bin/mkdir -p ${x}")
                |> (a: pkgs.writeShellScript "${n}-mkdir" (a + "\nexit 0\n"))
              )
            ];
          }
        ) v;
      in
      pkgs.writeTextDir n (lib'.toSystemdUnit val)
    ) cfg.quadlets;
  };
in
{
  options.programs.quadlets = {
    enable = mkEnableOption "Podman's Quadlets";
    mkdir = mkEnableOption "Creating directories if they don't exist.";
    quadlets = mkOption {
      default = { };
      type =
        with types;
        let
          primitive = oneOf [
            bool
            int
            str
            path
          ];
        in
        attrsOf (attrsOf (attrsOf (either primitive (listOf primitive))))
        // {
          description = "Quadlet configuration.";
        };
      description = "All the quadlets that need to have systemd unit files generated";
    };
    restart-all-units = mkEnableOption "creating a script that restarts all units" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."systemd/user/" = {
      source = "${
        pkgs.runCommand "quadlet-generator" { } ''
          mkdir -p $out $out/src $out/units

          ln -s ${quadlets} $out/src

          QUADLET_UNIT_DIRS=${quadlets} ${osConfig.virtualisation.podman.package}/libexec/podman/quadlet -user $out/units

          for file in $(find $out/units -type f -exec realpath --relative-to $out/units {} \;); do
            substituteInPlace $out/units/$file \
              --replace-warn ${quadlets}/\$\{XDG_RUNTIME_DIR} \$\{XDG_RUNTIME_DIR} \
              --replace-warn \\x20 " "
          done
        ''
      }/units";
      recursive = true;
    };

    home.packages = optional cfg.restart-all-units (
      pkgs.writeShellScriptBin "restart-all-podman-units" "systemctl --user restart ${
        concatMapStringsSep " " (
          x:
          replaceStrings
            [ ".container" ".network" ".volume" ]
            [ ".service" "-network.service" "-volume.service" ]
            x
        ) (attrNames cfg.quadlets)
      }"
    );
  };
}
