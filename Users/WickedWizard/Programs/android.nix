{ config, pkgs, ... }:
let cryptor = pkgs.callPackage ../../../Packages/cryptor.nix { };
in {
  home.packages = with pkgs; [
    android-tools
    android-udev-rules
    cryptor
  ];
}
