{ config, pkgs, ... }: {
  imports = [
    ./joplin.nix
    ./libreoffice.nix
    ./newsflash.nix
  ];
}
