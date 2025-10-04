{ config, ... }:
{
  nixpkgs.config.permittedInsecurePackages =
    [ ] ++ config.hm-config.nixpkgs.config.permittedInsecurePackages;
}
