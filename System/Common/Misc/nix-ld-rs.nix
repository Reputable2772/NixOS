{ config, pkgs, inputs, lib, ... }:
let
  inherit (lib.attrsets) attrValues filterAttrs mapAttrs;
  inherit (lib.lists) concatLists;
  inherit (lib.trivial) pipe;
in
{
  programs.nix-ld = {
    enable = true;
    package = inputs.nix-ld-rs.packages.${pkgs.system}.nix-ld-rs;

    # All packages installed by any user that has HM.
    libraries = pipe config.users.users [
      (filterAttrs (n: v: v.isNormalUser))
      (mapAttrs (n: v: config.home-manager.users.${n}.home.packages))
      attrValues
      concatLists
    ];
  };
}
