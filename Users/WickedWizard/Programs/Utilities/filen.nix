{ config, pkgs, ... }:
let filen = pkgs.callPackage ../../../../Packages/filen.nix { };
in {
  home.packages = with pkgs; [ filen ];
}
