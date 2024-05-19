{ config, lib, pkgs, ... }:

let
  inherit (lib) types trivial;
  inherit (lib.lists) elem map;
  inherit (lib.options) literalExpression mkOption;
  inherit (lib.strings) removeSuffix;
  cfg = config.programs.firejail;
in
{
  options.programs.firejail = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Enable Firejail Home-Manager Module
      '';
    };

    packages = mkOption {
      default = [ ];
      example = literalExpression "[ pkgs.gnome.pomodoro ]";
      type = types.listOf types.package;
      description = lib.mdDoc "Packages that need to be included from Firejail.";
    };

    excludedPackages = mkOption {
      default = [ ];
      example = literalExpression "[ pkgs.gnome.pomodoro ]";
      type = types.listOf types.package;
      description = lib.mdDoc "Packages that need to be excluded from Firejail.";
    };
  };

  config = {
    home.packages = lib.mkIf cfg.enable [
      (
        pkgs.runCommand "firejail-wrapped-apps"
          {
            # Take higher priority over non-firejailed versions
            meta.priority = -1;
          }
          ''
            mkdir -p $out/bin $out/share/applications

            ${lib.concatStringsSep "\n" (map (x:
              let
                # The package name format is `name-version`, so we remove suffix of `-version`.
                pname = if x.meta ? mainProgram then x.meta.mainProgram else removeSuffix "-${lib.getVersion x.name}" x.name;
                # This is required to prevent an infinite recursion, but why the recursion occurs is currently a mystery.
                excluded_pkgs_name = map (pkg: pkg.name) cfg.excludedPackages;
              in
                if pname != null && !(elem x.name excluded_pkgs_name) && (trivial.pathExists "${pkgs.firejail}/etc/firejail/${pname}.profile") then
                  let
                    bpath = lib.getExe' x pname;
                  in
                    ''
                      cat <<_EOF >$out/bin/${pname}
                      #! ${pkgs.runtimeShell} -e
                      exec /run/wrappers/bin/firejail --profile ${pkgs.firejail}/etc/firejail/${pname}.profile -- ${bpath}
                      _EOF

                      chmod 0755 $out/bin/${pname}

                      # Remove hardcoding from desktop files that have firejail enabled.
                      for file in ${x}/share/applications/*.desktop; do
                        if grep -q "${bpath}" $file; then
                          substitute $file $out/share/applications/$(basename $file) \
                            --replace ${bpath} $out/bin/${pname}
                        fi
                      done
                    ''
                else
                  ""
            ) cfg.packages)}
          ''
      )
    ];
  };
}

