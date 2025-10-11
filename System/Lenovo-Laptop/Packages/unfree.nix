{ config, lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) (
      [
        "spotify"
      ]
      ++ config.hm-config.nixpkgs.config.allowUnfreePredicate
    );
}
