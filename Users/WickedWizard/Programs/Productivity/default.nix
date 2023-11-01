{ config, pkgs, ... }: {
  imports = [
    ./fluent-reader.nix
    ./joplin.nix
    ./libreoffice.nix
    ./newsflash.nix
    ./task-timer.nix
    ./rssguard.nix
  ];
}
