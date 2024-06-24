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
  };

  outputs = { nixpkgs, self, devshell, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib' = import ./lib { inherit pkgs; };
      config' = import ./Config/config.nix;
      sources = import ./_sources/generated.nix { inherit (pkgs) fetchurl fetchgit fetchFromGitHub dockerTools; };
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;
      build =
        let
          inherit (pkgs) lib writeText;
          inherit (lib.attrsets) mapAttrs;
        in
        writeText "build.json"
          (builtins.toJSON [
            (mapAttrs (name: value: value.config.system.build.toplevel) self.nixosConfigurations)
            (self.devShells.${system})
          ]);
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
        let
          overlayed_pkgs = import nixpkgs {
            inherit system;
            overlays = [ devshell.overlays.default ];
          };
        in
        pkgs.lib.attrsets.mapAttrs
          (name: value: import value {
            inherit inputs sources;
            pkgs = overlayed_pkgs;
          })
          (lib'.recurseDirectory ./Shells false);
    };
}
