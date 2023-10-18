{ config, pkgs, ... }: {
  imports = [
    ./joplin.nix
    ./libreoffice.nix
    ./newsflash.nix
    ./task-timer.nix
    ./rssguard.nix
  ];
}
