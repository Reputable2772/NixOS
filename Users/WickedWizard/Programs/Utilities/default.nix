{ config, pkgs, ... }: {
  imports = [
    ./celeste.nix
    ./filen.nix
    ./kitty.nix
    ./protonvpn.nix
    # ./rclone.nix
  ];
}
