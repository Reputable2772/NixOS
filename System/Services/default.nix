{ config, pkgs, ... }: {
  imports = [
    ./pipewire.nix
    ./syncthing.nix
    ./xserver.nix
  ];
}
