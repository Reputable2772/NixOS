{
  description = "Nix Flakes for my System.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Packages are effectively in cache.nixos.org as soon as they are built by Hydra.
    # So I don't think this requires that many builds from source.
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-index-database.url = "github:nix-community/nix-index-database";
    menucalc = {
      url = "github:sumnerevans/menu-calc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote.url = "github:nix-community/lanzaboote/v0.3.0";
    nix-ld-rs.url = "github:nix-community/nix-ld-rs";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, self, devshell, flake-parts, git-hooks, systems, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        devshell.flakeModule
        git-hooks.flakeModule
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
              polyfill = false;
              lib' = import ./lib { inherit pkgs; };
              sources = import ./_sources/generated.nix { inherit (pkgs) fetchurl fetchgit fetchFromGitHub dockerTools; };
            };
            modules = [
              ./System/Common
              ./System/HP-Laptop

              ({ config, ... }: {
                _module.args = {
                  config' = import ./Config/config.nix {
                    _home = pkgs.lib.attrsets.mapAttrs (n: v: v.home.homeDirectory) config.home-manager.users;
                  };
                };
              })
            ];
          };

        "rescue" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            polyfill = true;
          };
          modules = [
            ./System/Common
            ./System/Rescue
          ];
        };
      };

      perSystem = { config, system, pkgs, self', ... }:
        let
          inherit (pkgs) lib writeText;
          inherit (lib.attrsets) filterAttrs mapAttrs;
          inherit (lib.strings) hasSuffix;
        in
        {
          formatter = pkgs.nixpkgs-fmt;

          # Installation hooks need to setup manually in each devshell.
          pre-commit.check.enable = true;
          pre-commit.settings.hooks = {
            commitizen.enable = true;
            nixpkgs-fmt.enable = true;
          };

          packages.build =
            writeText "build.json"
              (builtins.toJSON [
                (mapAttrs (name: value: value.config.system.build.${if name == "rescue" then "isoImage" else "toplevel"}) (filterAttrs (n: v: v.pkgs.system == system) self.nixosConfigurations))
                self'.devShells
              ]);

          devshells = mapAttrs
            (name: value: import value {
              inherit config inputs pkgs;
              sources = import ./_sources/generated.nix { inherit (pkgs) fetchurl fetchgit fetchFromGitHub dockerTools; };
            })
            (filterAttrs (n: v: hasSuffix "nix" v) ((import ./lib { inherit pkgs; }).recurseDirectory ./Shells false));
        };
    };
}
