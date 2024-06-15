{ config, lib, ... }:
let
  inherit (lib) mkForce;
  inherit (lib.attrsets) filterAttrs mapAttrs;
in
{
  # TODO: Declaratively configure rules.
  services.opensnitch.enable = true;

  home-manager = {
    # Needed since it causes an infinite recursion otherwise.
    useUserPackages = mkForce (!config.services.opensnitch.enable);
    users = mapAttrs
      (n: v: { services.opensnitch-ui.enable = true; })
      (filterAttrs (n: v: v.isNormalUser) config.users.users);
  };
}
