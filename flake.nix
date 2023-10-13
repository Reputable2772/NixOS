{
  description = "Nix Flakes for my System.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://cache.nixos.org/"
    ];
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nur.nixosModules.nur
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [
              inputs.nur.overlay
              (import ./Overlays/prismlauncher.nix)
              (import ./Overlays/dconf2nix.nix)
              (import ./Overlays/rssguard.nix)
            ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wickedwizard = {
              imports = [ ./WickedWizard/home.nix ];
              _module.args.nur = { inherit nur; };
            };
            home-manager.users.shuba = import ./Shuba/home.nix;
          }
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
