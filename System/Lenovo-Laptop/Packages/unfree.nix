{ config, lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) config.hm-config.nixpkgs.config.allowUnfreePredicate;
}
