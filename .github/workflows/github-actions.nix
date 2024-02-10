{ pkgs ? import <nixpkgs> {
  overlays = import ../../Overlays;
} }:
let
  filen = pkgs.callPackage ../../Packages/filen.nix { };
  firefox-theme = pkgs.callPackage ../../Packages/firefox-gnome-theme.nix { };
  rtl8821ce = pkgs.linuxKernel.packages.linux_zen.callPackage ../../Packages/rtl8821ce.nix { };
in pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    filen
    firefox-theme
    prismlauncher-qt5
    dconf2nix
    rtl8821ce
  ];
}
