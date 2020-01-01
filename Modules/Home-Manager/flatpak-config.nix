{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) types;
  inherit (lib.attrsets) attrNames concatMapAttrs optionalAttrs;
  inherit (lib.lists) elemAt filter;
  inherit (lib.options) literalExpression mkEnableOption mkOption;
  inherit (lib.strings) hasInfix removePrefix;

  cfg = config.programs.flatpak-config;
  fileType =
    (import "${inputs.home-manager}/modules/lib/file-type.nix" {
      inherit lib pkgs;
      inherit (config.home) homeDirectory;
    }).fileType;
  modifiedFiles = concatMapAttrs (
    name: file:
    let
      # Check if package exists for particular file.
      filteredPackage = filter (pname: hasInfix pname file.target) (attrNames cfg.packages);
    in
    optionalAttrs (filteredPackage != [ ]) {
      # If it exists, get value for package name and modify file name and target.
      ${if cfg.replace then name else file.target} = file // {
        target = ".var/app/${
          cfg.packages.${elemAt filteredPackage 0}
        }/${removePrefix "${config.home.homeDirectory}/" file.target}";
      };
    }
  ) config.home.file;
in
{
  options.programs.flatpak-config = {
    enable = mkEnableOption "flatpak file redirection module";

    replace = mkEnableOption "replacing of existing files with flatpak files. Files co-exist by default.";

    packages = mkOption {
      default = { };
      example = literalExpression ''{ joplin-desktop = "net.cozic.joplin_desktop"; }'';
      type = types.attrsOf types.str;
      description = lib.mdDoc "Package name in target and flatpak id of package.";
    };

    files = mkOption {
      internal = true;
      readOnly = true;
      default = optionalAttrs cfg.enable modifiedFiles;
      type = fileType "programs.flatpak-config.files" "{env}`HOME`" config.home.homeDirectory;
      description = lib.mdDoc "Files that have been modified, and can be set.";
    };
  };
}
