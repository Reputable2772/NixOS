{
  inputs,
  config',
  lib,
  ...
}:
let
  inherit (lib.attrsets) filterAttrs mapAttrsToList;
in
{
  imports = [
    inputs.agenix.homeManagerModules.default
  ];

  age.identityPaths = lib.pipe config'.secrets [
    (filterAttrs (n: v: v ? pkeyfile && v.pkeyfile != null))
    (mapAttrsToList (n: v: v.pkeyfile))
  ];
}
