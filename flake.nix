{
  description = "Nix Flakes for my System.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
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

    # Require manual updates, nix flake update will not work.
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.5.2";
  };

  outputs =
    {
      nixpkgs,
      self,
      devshell,
      flake-parts,
      git-hooks,
      systems,
      ...
    }@inputs:
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
              lib' = import ./lib { inherit pkgs; };
              sources = import ./_sources/generated.nix {
                inherit (pkgs)
                  fetchurl
                  fetchgit
                  fetchFromGitHub
                  dockerTools
                  ;
              };
            };
            modules = [
              ./System/Common
              ./System/HP-Laptop

              (
                { config, ... }:
                {
                  _module.args.config' = import ./Config/config.nix {
                    _home = pkgs.lib.attrsets.mapAttrs (n: v: v.home.homeDirectory) config.home-manager.users;
                  };
                }
              )
            ];
          };

        "rescue" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;

            config' = import ./Config/config.nix { };
          };
          modules = [
            ./System/Common
            ./System/Rescue
          ];
        };
      };

      perSystem =
        {
          config,
          system,
          pkgs,
          self',
          ...
        }:
        let
          inherit (pkgs) lib;
          inherit (lib.attrsets) filterAttrs mapAttrs;
          inherit (lib.strings) hasSuffix;
        in
        {
          formatter = pkgs.nixfmt-rfc-style;

          # Installation hooks need to setup manually in each devshell.
          pre-commit.check.enable = true;
          pre-commit.settings.hooks = {
            commitizen.enable = true;
            nixfmt-rfc-style = {
              enable = true;
              package = pkgs.nixfmt-rfc-style;
            };
          };

          devshells =
            mapAttrs
              (
                name: value:
                import value {
                  inherit config inputs pkgs;
                  sources = import ./_sources/generated.nix {
                    inherit (pkgs)
                      fetchurl
                      fetchgit
                      fetchFromGitHub
                      dockerTools
                      ;
                  };
                }
              )
              (
                filterAttrs (n: v: hasSuffix "nix" v) (
                  (import ./lib { inherit pkgs; }).recurseDirectory ./Shells false
                )
              );
        };
    };
}
