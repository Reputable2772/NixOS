{
  description = "Nix Flakes for my System.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unfree = {
      url = "github:numtide/nixpkgs-unfree";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    home-manager.url = "github:nix-community/home-manager";
    nur.url = "github:nix-community/NUR";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = { nixpkgs, pre-commit-hooks, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib' = import ./lib { inherit nixpkgs; };
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;
      nixosConfigurations = {
        "hp-laptop" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs lib';
          };
          modules = [
            ./System/Common
            ./System/HP-Laptop
          ];
        };
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
