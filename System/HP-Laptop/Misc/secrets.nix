{ inputs, config', lib, ... }:
{
  imports = [
    inputs.agenix.nixosModules.default
  ];

  # SSH private keys for the system side.
  age.identityPaths = lib.pipe config'.system.secrets
    (with lib.attrsets; [
      (concatMapAttrs (_: v:
        if v ? pkeyfile then
          { ${_} = v.pkeyfile; }
        else
          (mapAttrs (n: v: v.pkeyfile) (filterAttrs (a: b: b ? pkeyfile) v))
      ))
      attrValues
    ]);
}
