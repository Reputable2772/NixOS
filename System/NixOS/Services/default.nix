{ config, pkgs, ... }: {
  imports = [
    ./flatpak.nix
    ./fwupd.nix
    ./pipewire.nix
    ./restic.nix
    ./syncthing.nix
    ./xserver.nix
  ];
}
