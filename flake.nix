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
    home-manager.url = "github:nix-community/home-manager";
    nur.url = "github:nix-community/NUR";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    cachix-deploy-flake.url = "github:cachix/cachix-deploy-flake";
  };

  outputs = { nixpkgs, pre-commit-hooks, cachix-deploy-flake, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib' = import ./lib { inherit pkgs; };
      cachix-deploy-lib = cachix-deploy-flake.lib pkgs;
      hp-laptop = {
        inherit system;
        specialArgs = {
          inherit inputs lib';
        };
        modules = [
          ./System/Common
          ./System/HP-Laptop
        ];
      };
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;
      cachix-deploy.${system}.default = cachix-deploy-lib.spec {
        agents."hp-laptop" = (nixpkgs.lib.nixosSystem hp-laptop).config.system.build.toplevel;
      };
      nixosConfigurations = {
        "hp-laptop" = nixpkgs.lib.nixosSystem hp-laptop;
      };
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          curl
          jq
          hydra-check
          nixpkgs-fmt
        ];
        shellHook = pkgs.lib.strings.concatStrings [
          # Fixes https://github.com/direnv/direnv/issues/73
          # "export_alias codium 'codium --profile Nix $@'"
          "\n"
          (pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              nixpkgs-fmt.enable = true;
              commitizen.enable = true;
            };
          }).shellHook
        ];
      };
    };
}
