{ pkgs ? import <nixpkgs> {
  overlays = import ./Overlays;
} }:
let
  filen = import ./Packages/filen.nix;
  firefox-theme = import ./Packages/firefox-gnome-theme.nix;
in pkgs.mkShell {
  buildInputs = [
    filen
    firefox-theme
    prismlauncher-qt5-unwrapped
    dconf2nix
  ];
}
