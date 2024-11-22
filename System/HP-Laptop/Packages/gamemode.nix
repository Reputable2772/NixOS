{ config, lib, ... }:
{
  programs.gamemode.enable = true;

  users.users.wickedwizard.extraGroups = lib.optional config.programs.gamemode.enable "gamemode";
}
