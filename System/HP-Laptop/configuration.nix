{ pkgs, inputs, ... }:
let
  inherit (inputs) nur home-manager nixpkgs;
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

