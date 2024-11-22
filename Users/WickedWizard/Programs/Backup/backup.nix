{ config', ... }:
{
  programs.backup = {
    inherit (config'.backup) repository;
    paths = {
      inherit (config'.backup.paths) include exclude;
    };
    enable = true;
  };
}
