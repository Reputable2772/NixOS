{ config, pkgs, ... }: {
  imports = [
    ./backup.nix
    ./containers.nix
    ./easyeffects.nix
    ./gpg.nix
    ./flameshot.nix
    ./opensnitch.nix
  ];
}
