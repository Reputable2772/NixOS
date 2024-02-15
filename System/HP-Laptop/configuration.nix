{ config, pkgs, inputs, ... }:
let
  inherit (inputs) nur home-manager flatpaks nixpkgs;
in
{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "beeper"
    "discord"
    "spotify"
    "steam"
    "steam-original"
    "steam-run"
  ];
  nixpkgs.overlays = [ nur.overlay ] ++ import ../../Overlays;

  # Needs to be set here or else shell won't work
  programs.zsh.enable = true;
  # Shell autocomplete
  environment.pathsToLink = [ "/share/zsh" ];

  nix.settings.trusted-users = [ "wickedwizard" ];
  users.users.wickedwizard = {
    isNormalUser = true;
    home = "/home/wickedwizard";
    description = "WickedWizard";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      wickedwizard = {
        imports = [
          ../../Users/WickedWizard/home.nix
          flatpaks.homeManagerModules.default
        ];
      };
    };
    extraSpecialArgs = {
      inherit inputs;
    };
  };

  imports = [
    nur.nixosModules.nur
    home-manager.nixosModules.home-manager
    ../configuration.nix
  ];
}

