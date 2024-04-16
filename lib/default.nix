{ nixpkgs }:
let
  inherit (nixpkgs) lib;
in
{
  absoluteToRelativePath = import ./absoluteToRelativePath.nix { inherit lib; };
}
