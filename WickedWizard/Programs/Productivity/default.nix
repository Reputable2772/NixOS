{ config, pkgs, ... }: {
  imports = [
    ./newsflash.nix
    ./joplin.nix
    ./task-timer.nix
    ./rssguard.nix
  ];
}
