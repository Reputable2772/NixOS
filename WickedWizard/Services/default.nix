{ config, pkgs, ... }: {
  imports = [
    ./easyeffects.nix
    ./gpg.nix
    ./flameshot.nix
    ./podman.nix
  ];
}
