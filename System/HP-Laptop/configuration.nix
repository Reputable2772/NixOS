{ config, config', pkgs, inputs, lib', sources, ... }:
let
  inherit (inputs) nur home-manager nixpkgs-wayland;
in
{
  nixpkgs.overlays = [
    nur.overlay
    nixpkgs-wayland.overlay
  ] ++ import ../../Overlays;

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
    backupFileExtension = "bak";
    users = {
      wickedwizard = {
        imports = [
          ../../Users/WickedWizard/home.nix
          ../../Modules/Home-Manager
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
      inherit inputs lib' sources config';
    };
  };

  imports = [
    home-manager.nixosModules.home-manager
  ];
}
