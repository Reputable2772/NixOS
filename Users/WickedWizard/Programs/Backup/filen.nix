{ pkgs, ... }:
let
  filen = pkgs.callPackage ../../../../Packages/filen.nix { };
in
{
  home.packages = [ filen ];

  programs.autostart.autostartPackages = [ filen ];
}
