{ ... }: {
  imports = [
    ./avahi.nix
    ./flatpak.nix
    ./fwupd.nix
    ./keyring.nix
    ./opensnitch.nix
    ./pipewire.nix
    ./ssh.nix
    ./syncthing.nix
    ./tlp.nix
    ./xserver.nix
  ];
}
