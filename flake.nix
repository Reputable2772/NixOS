{
  description = "Nix Flakes for my System.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Packages are effectively in cache.nixos.org as soon as they are built by Hydra.
    # So I don't think this requires that many builds from source.
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-unfree = {
      url = "github:numtide/nixpkgs-unfree";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    cachix-deploy-flake.url = "github:cachix/cachix-deploy-flake";
    nvfetcher.url = "github:berberman/nvfetcher";
  };

  outputs = { nixpkgs, pre-commit-hooks, cachix-deploy-flake, self, nvfetcher, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib' = import ./lib { inherit pkgs; };
      sources = import ./_sources/generated.nix { inherit (pkgs) fetchurl fetchgit fetchFromGitHub dockerTools; };
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;
      cachix-deploy = (cachix-deploy-flake.lib pkgs).spec {
        agents = pkgs.lib.attrsets.mapAttrs (name: value: value.config.system.build.toplevel) self.nixosConfigurations;
      };
      nixosConfigurations = {
        "hp-laptop" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs lib' sources;
          };
          modules = [
            ./System/Common
            ./System/HP-Laptop
          ];
        };
      };
      devShells.${system} =
        let
          inherit (pkgs.lib) attrsets lists strings;
        in
        (attrsets.genAttrs
          (lists.forEach
            (attrsets.attrNames (builtins.readDir ./Shells))
            (str: strings.removeSuffix ".nix" str))
          (name: import (./Shells + "/${name}.nix") { inherit pkgs inputs sources; }));
    };
}
