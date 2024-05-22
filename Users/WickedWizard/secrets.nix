{ inputs, config, config', lib, ... }:
{
  imports = [
    inputs.agenix.homeManagerModules.default
  ];

  # SSH private keys for the user side.
  age.identityPaths = lib.pipe config'.users.${config.home.username}.secrets
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
