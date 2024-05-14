{ pkgs, sources, ... }:
let
  filen = pkgs.callPackage ../../../../Packages/filen.nix { inherit sources; };
in
{
  home.packages = [ filen ];

  programs.autostart.packages = [ filen ];
}
