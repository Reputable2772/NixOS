{ config, pkgs, ... }: {
  imports = [
    ./bitwarden.nix
    ./picard.nix
    ./podman.nix
  ];
}
