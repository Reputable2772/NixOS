{ config, pkgs, inputs, ... }:
let
  inherit (inputs) nur home-manager flatpaks nixpkgs;
in
{
  time.timeZone = "Asia/Kolkata";

  imports = [
    nur.nixosModules.nur
    home-manager.nixosModules.home-manager
    {
      nixpkgs.overlays = [ nur.overlay ] ++ (import ../Overlays);
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users = {
          wickedwizard = {
            imports = [
              ../Users/WickedWizard/home.nix
              flatpaks.homeManagerModules.default
            ];
          };
        };
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    }
  ];

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 2d";
    };
    settings.experimental-features = [ "flakes" "nix-command" ];
  };

  system.stateVersion = "23.05";
}

