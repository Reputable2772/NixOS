{ config, pkgs, ... }: {
  imports = [
    ./bitwarden.nix
    ./feishin.nix
    ./picard.nix
    ./podman.nix
  ];
}
