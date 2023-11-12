{ config, pkgs, ... }: {
  imports = [
    ./flatpak.nix
    ./fwupd.nix
    ./mysql.nix
    ./opensnitch.nix
    ./pipewire.nix
    ./syncthing.nix
    ./tlp.nix
    ./touchpad.nix
    ./xserver.nix
  ];
}
