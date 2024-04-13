{ config, pkgs, inputs, ... }:
let
  inherit (inputs) nur home-manager nixpkgs nixpkgs-wayland;
in
{
  nixpkgs.overlays = [ nur.overlay nixpkgs-wayland.overlay ] ++ import ../../Overlays;
  nix.registry.nixpkgs.flake = nixpkgs;

  # Needs to be set here or else shell won't work
  programs.zsh.enable = true;
  # Shell autocomplete
  environment.pathsToLink = [ "/share/zsh" ];

  users.users.wickedwizard = {
    isNormalUser = true;
    home = "/home/wickedwizard";
    description = "WickedWizard";
    # Fixes https://github.com/GPUOpen-Drivers/AMDVLK/issues/310
    extraGroups = [ "wheel" "networkmanager" "input" "video" "render" ];
    shell = pkgs.zsh;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      wickedwizard = {
        imports = [
          ../../Users/WickedWizard/home.nix
          {
            home = {
              username = "wickedwizard";
              homeDirectory = config.users.users.wickedwizard.home;
              stateVersion = "23.05";
            };
          }
        ];
      };
    };
    extraSpecialArgs = {
      inherit inputs;
    };
  };

  programs.config_dir = {
    config_dir = "${config.users.users.wickedwizard.home}/Documents/Config";
    browser_dir = "${config.users.users.wickedwizard.home}/Documents/Browsers";
    self_dir = "${config.users.users.wickedwizard.home}/Documents/NixOS";
  };

  imports = [
    nur.nixosModules.nur
    home-manager.nixosModules.home-manager

    ../Common
    ../../Modules/System
  ];
}

