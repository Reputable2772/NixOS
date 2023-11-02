{ config, pkgs, ... }: {
  imports = [
    ./fractal.nix
    ./schildichat.nix
    ./signal.nix
  ];
}
