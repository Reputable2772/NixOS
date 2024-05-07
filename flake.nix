{
  description = "Nix Flakes for my System.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Packages are effectively in cache.nixos.org as soon as they are built by Hydra.
    # So I don't think this requires that many builds from source.
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    agenix.url = "github:ryantm/agenix";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = { nixpkgs, pre-commit-hooks, self, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib' = import ./lib { inherit pkgs; };
      config' = import ./Config/config.nix;
      sources = import ./_sources/generated.nix { inherit (pkgs) fetchurl fetchgit fetchFromGitHub dockerTools; };
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;
      cachix-deploy = pkgs.writeText "cachix-deploy.json" (builtins.toJSON {
        agents = pkgs.lib.attrsets.mapAttrs (name: value: value.config.system.build.toplevel) self.nixosConfigurations;
      });
      nixosConfigurations = {
        "hp-laptop" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs lib' sources config';
          };
          modules = [
            ./System/Common
            ./System/HP-Laptop
          ];
        };
      };
      devShells.${system} =
        pkgs.lib.attrsets.mapAttrs (name: value: import value { inherit pkgs inputs sources; }) (lib'.recurseDirectory ./Shells);
    };
}
