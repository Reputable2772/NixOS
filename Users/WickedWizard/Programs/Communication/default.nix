{ config, pkgs, ... }: {
  imports = [
    ./schildichat.nix
    ./signal.nix
  ];
}
