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
    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs = { nixpkgs, self, devshell, flake-parts, pre-commit-hooks-nix, systems, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        devshell.flakeModule
        pre-commit-hooks-nix.flakeModule
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
              polyfill = false;
              lib' = import ./lib { inherit pkgs; };
              sources = import ./_sources/generated.nix { inherit (pkgs) fetchurl fetchgit fetchFromGitHub dockerTools; };
            };
            modules = [
              ./System/Common
              ./System/HP-Laptop
            ];
          };
      };

      perSystem = { config, system, pkgs, self', ... }: {
        formatter = pkgs.nixpkgs-fmt;

        # Installation hooks need to setup manually in each devshell.
        pre-commit.check.enable = true;
        pre-commit.settings.hooks = {
          commitizen.enable = true;
          nixpkgs-fmt.enable = true;
        };

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
            inherit config inputs pkgs;
            sources = import ./_sources/generated.nix { inherit (pkgs) fetchurl fetchgit fetchFromGitHub dockerTools; };
          })
          ((import ./lib { inherit pkgs; }).recurseDirectory ./Shells false);
      };
    };
}
