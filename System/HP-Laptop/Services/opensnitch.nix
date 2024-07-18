{ config, lib, ... }:
let
  inherit (lib.attrsets) filterAttrs mapAttrs;
in
{
  # TODO: Declaratively configure rules.
  services.opensnitch.enable = false;

  home-manager = {
    users = mapAttrs
      (n: v: { services.opensnitch-ui.enable = config.services.opensnitch.enable; })
      (filterAttrs (n: v: v.isNormalUser) config.users.users);
  };
}
