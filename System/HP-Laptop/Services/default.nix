{ config, pkgs, ... }: {
  imports = [
    ./avahi.nix
    ./flatpak.nix
    ./fwupd.nix
    ./mysql.nix
    ./opensnitch.nix
    ./pipewire.nix
    ./ssh.nix
    ./syncthing.nix
    ./tlp.nix
    ./xserver.nix
  ];
}
