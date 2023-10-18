{ config, pkgs, ... }: {
  imports = [
    ./containers.nix
    ./easyeffects.nix
    ./gpg.nix
    ./flameshot.nix
  ];
}
