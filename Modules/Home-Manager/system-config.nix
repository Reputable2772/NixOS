{ lib, ... }:
import ../config-module.nix {
  inherit lib;
  name = "system-config";
  config = { };
}
