{ config, pkgs, ... }: {
  imports = [
    ./pipewire.nix
    ./syncthing.nix
    ./fwupd.nix
    ./xserver.nix
    ./restic.nix
  ];
}
