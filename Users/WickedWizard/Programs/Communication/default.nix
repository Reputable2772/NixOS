{ config, pkgs, ... }: {
  imports = [
    ./fractal.nix
    ./konversation.nix
    # ./schildichat.nix
    ./signal.nix
  ];
}
