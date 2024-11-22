{ osConfig, pkgs, ... }:
{
  home.packages = with pkgs; [
    (lutris.override {
      extraLibraries = pkgs: osConfig.programs.nix-ld.libraries;
      # Fixes NixOS/nixpkgs#285748
      extraPkgs = pkgz: with pkgz; [ winetricks ];
      # Since steam is a flatpak.
      steamSupport = false;
    })
  ];
}
