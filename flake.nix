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
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    menucalc = {
      url = "github:sumnerevans/menu-calc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld-rs.url = "github:nix-community/nix-ld-rs";
    devshell.url = "github:numtide/devshell";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };

  outputs = { nixpkgs, self, devshell, flake-parts, systems, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        devshell.flakeModule
      ];

      systems = import systems;

      flake.nixosConfigurations = {
        "hp-laptop" =
          let
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit inputs;
              config' = import ./Config/config.nix;
              lib' = import ./lib { inherit pkgs; };
              sources = import ./_sources/generated.nix { inherit (pkgs) fetchurl fetchgit fetchFromGitHub dockerTools; };
            };
            modules = [
              ./System/Common
              ./System/HP-Laptop
            ];
          };
      };

      perSystem = { system, pkgs, self', ... }: {
        formatter = pkgs.nixpkgs-fmt;

        packages.build =
          let
            inherit (pkgs) lib writeText;
            inherit (lib.attrsets) filterAttrs mapAttrs;
          in
          writeText "build.json"
            (builtins.toJSON [
              (mapAttrs (name: value: value.config.system.build.toplevel) (filterAttrs (n: v: v.pkgs.system == system) self.nixosConfigurations))
              self'.devShells
            ]);

        devshells = pkgs.lib.attrsets.mapAttrs
          (name: value: import value {
            inherit inputs pkgs;
            sources = import ./_sources/generated.nix { inherit (pkgs) fetchurl fetchgit fetchFromGitHub dockerTools; };
          })
          ((import ./lib { inherit pkgs; }).recurseDirectory ./Shells false);
      };
    };
}
