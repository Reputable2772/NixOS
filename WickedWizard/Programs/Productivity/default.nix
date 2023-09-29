{ config, pkgs, ... }: {
  imports = [
    ./newsflash.nix
    ./joplin.nix
  ];
}
