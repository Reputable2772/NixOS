{ lib, ... }:
import ../Common/config-module.nix {
  inherit lib;
  name = "system-config";
  config = { };
}
