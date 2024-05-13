{ inputs, config, config', lib, ... }:
{
  imports = [
    inputs.agenix.homeManagerModules.default
  ];

  # SSH private keys for the user side.
  age.identityPaths = lib.pipe config'.users.${config.home.username}.secrets
    (with lib.attrsets; [
      (filterAttrs (_: v: v ? pkeyfile))
      (mapAttrs (n: v: v.pkeyfile))
      attrValues
    ]);
}
