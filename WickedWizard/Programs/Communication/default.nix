{ config, pkgs, ... }: {
  imports = [
    ./schildichat.nix
    ./fractal.nix
    ./signal.nix
  ];
}
