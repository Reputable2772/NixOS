{ config, pkgs, inputs, ... }:
{
  nix.settings.trusted-users = [ "wickedwizard" ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "beeper"
    "discord"
    "spotify"
    "steam"
    "steam-original"
    "steam-run"
  ];

  # Needs to be set here or else shell won't work
  programs.zsh.enable = true;
  # Shell autocomplete
  environment.pathsToLink = [ "/share/zsh" ];

  users.users.wickedwizard = {
    isNormalUser = true;
    home = "/home/wickedwizard";
    description = "WickedWizard";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  imports = [
    ../configuration.nix
  ];
}

