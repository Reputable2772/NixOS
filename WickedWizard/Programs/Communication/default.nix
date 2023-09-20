{ config, pkgs, ... }: {
  imports = [
    ./beeper.nix
    ./schildichat.nix
  ];
}
