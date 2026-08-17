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
      base = "\${XDG_RUNTIME_DIR}/secrets";
      generation = "\${XDG_RUNTIME_DIR}/secrets.d";
    };
    system = false;
  };
  config' = config;
  inherit
    pkgs
    lib
    lib'
    ;

}
