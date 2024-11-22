{
  inputs,
  config,
  config',
  lib,
  ...
}:
let
  inherit (lib.attrsets) attrValues filterAttrs mapAttrs;
in
{
  imports = [
    inputs.agenix.nixosModules.default
  ];

  # SSH private keys for the system side.
  age.identityPaths = lib.pipe config'.system.${config.networking.hostName}.secrets [
    (filterAttrs (n: v: v ? pkeyfile && v.pkeyfile != null))
    (mapAttrs (_: v: v.pkeyfile))
    attrValues
  ];
}
