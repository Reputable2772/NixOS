{
  description = "Nix Flakes for my System.";
  inputs = {
    flatpaks.url = "github:GermanBread/declarative-flatpak/stable";
    home-manager.url = "github:nix-community/home-manager";
    nix-alien.url = "github:thiagokokada/nix-alien";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nur.url = "github:nix-community/NUR";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://cache.nixos.org/"
      "https://wickedwizard-nixos.cachix.org"
    ];
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "wickedwizard-nixos.cachix.org-1:Kg+kktoDEBmy9jEt9P2x7asKGAKmbBElwdkU0IYNwHg="
    ];
  };

  outputs = { self, nixpkgs, home-manager, nur, spicetify-nix, flatpaks, nix-alien, ... }@inputs:
    let system = "x86_64-linux"; in {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations = {
        "hp-laptop" = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            nur.nixosModules.nur
            home-manager.nixosModules.home-manager
            ./System/HP-Laptop
            {
              nixpkgs.overlays = [ nur.overlay ] ++ (import ./Overlays);
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users = {
                  wickedwizard = {
                    imports = [
                      ./Users/WickedWizard/home.nix
                      flatpaks.homeManagerModules.default
                    ];
                  };
                  shuba = import ./Users/Shuba/home.nix;
                };
                extraSpecialArgs = {
                  inherit spicetify-nix nix-alien self system;
                };
              };
            }
          ];
        };
      };
      devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
        nativeBuildInputs = with nixpkgs.legacyPackages.x86_64-linux; [ pre-commit ];
      };
    };
}
