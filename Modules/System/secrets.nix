{
  config,
  pkgs,
  lib',
  lib,
  ...
}:
import ../Common/secrets.nix {
  extraArgs = {
    paths = {
      base = "/run/secrets";
      generation = "/run/secrets.d";
    };
    system = true;
  };
  config' = config;
  inherit
    pkgs
    lib
    lib'
    ;
}
