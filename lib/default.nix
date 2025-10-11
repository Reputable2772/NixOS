{ pkgs }:
let
  inherit (pkgs) lib;
in
{
  absoluteToRelativePath = import ./absoluteToRelativePath.nix { inherit lib; };
  recurseDirectory = import ./recurseDirectory.nix { inherit lib; };
  toSystemdUnit = import ./toSystemdUnit.nix { inherit lib; };
  deepMerge = import ./deepMerge.nix;

  # This is a derivation, rather than a function
  iniToNix = import ./iniToNix.nix { inherit pkgs; };
}
