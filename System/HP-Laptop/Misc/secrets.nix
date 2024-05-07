{ inputs, config', lib, ... }:
{
  imports = [
    inputs.agenix.nixosModules.default
  ];

  # SSH private keys for the system side.
  age.identityPaths = lib.pipe config'.system.secrets [
    (lib.attrsets.filterAttrs (_: v: v != null))
    (lib.attrsets.mapAttrs (n: v: v.pkeyfile))
    lib.attrsets.attrValues
  ];
}
