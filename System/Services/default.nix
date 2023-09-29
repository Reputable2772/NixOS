{ config, pkgs, ... }: {
  imports = [
    ./bluetooth.nix
    ./pipewire.nix
    ./syncthing.nix
    ./fwupd.nix
    ./xserver.nix
  ];
}
