{ inputs, ... }:
let
  inherit (inputs) nur nixpkgs-wayland;
in
{
  nixpkgs.overlays = [
    nur.overlay
    nixpkgs-wayland.overlay
  ] ++ import ../../../Overlays;
}
