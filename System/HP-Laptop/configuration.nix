{ pkgs, inputs, ... }:
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

  home-manager =
    let
      homeDir = h: "/home/${h}";
    in
    {
      useGlobalPkgs = true;
      useUserPackages = true;
      users = {
        wickedwizard =
          let
            home = "wickedwizard";
          in
          {
            imports = [
              ../../Users/WickedWizard/home.nix
              {
                home = {
                  username = home;
                  homeDirectory = homeDir home;
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

  imports = [
    nur.nixosModules.nur
    home-manager.nixosModules.home-manager

    ../Common
    ../../Modules/System
  ];
}

