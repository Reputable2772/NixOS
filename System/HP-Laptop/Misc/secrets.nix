{ inputs, config', lib, ... }:
{
  imports = [
    inputs.agenix.nixosModules.default
  ];

  # SSH private keys for the system side.
  age.identityPaths = lib.pipe config'.system.secrets
    (with lib.attrsets; [
      (filterAttrs (_: v: v != null))
      (mapAttrs (n: v: v.pkeyfile))
      attrValues
    ]);
}
