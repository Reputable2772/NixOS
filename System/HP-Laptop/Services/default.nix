{ config, pkgs, ... }: {
  imports = [
    ./flatpak.nix
    ./fwupd.nix
    ./mysql.nix
    ./opensnitch.nix
    ./pipewire.nix
    # ./restic.nix
    ./syncthing.nix
    ./tlp.nix
    ./xserver.nix
  ];
}
