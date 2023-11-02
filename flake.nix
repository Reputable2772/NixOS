{
  description = "Nix Flakes for my System.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:the-argus/spicetify-nix";
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
      "fractal-next.cachix.org-1:ptJEIB1fu2bsh2s+NmtyPWEJD7arXg9HnAfWv2+5XVc="
      "dconf2nix-latest.cachix.org-1:Xx1w9t1L6DC8J/mAQwwj9gCzKw/IBFj4KNU62ofjU6k="
    ];
  };

  outputs = { self, nixpkgs, home-manager, nur, spicetify-nix, ... }@inputs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    nixosConfigurations = {
      "hp-laptop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
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
                wickedwizard = import ./Users/WickedWizard/home.nix;
                shuba = import ./Users/Shuba/home.nix;
              };
              extraSpecialArgs = {
                inherit spicetify-nix;
              };
            };
          }
        ];
      };
    };
    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      nativeBuildInputs = with nixpkgs.legacyPackages.x86_64-linux; [ commitlint pre-commit ];
    };
  };
}
