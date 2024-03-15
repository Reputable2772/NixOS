{
  description = "Nix Flakes for my System.";
  inputs = {
    flatpaks.url = "github:GermanBread/declarative-flatpak/stable";
    home-manager.url = "github:nix-community/home-manager";
    nix-alien.url = "github:thiagokokada/nix-alien";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    matugen.url = "github:InioX/matugen";
    ags.url = "github:Aylur/ags";
  };

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://cache.nixos.org/"
      "https://spearman4157.cachix.org"
    ];
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "spearman4157.cachix.org-1:C5rIS9uufmlsdRIe9dEHSZVjxo9g8se+gjMdIeeEYfk="
    ];
  };

  outputs = { nixpkgs, pre-commit-hooks, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;
      nixosConfigurations = {
        "hp-laptop" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = [ ./System/HP-Laptop ];
        };
      };
      devShells.${system}.default = pkgs.mkShell {
        shellHook = pkgs.lib.strings.concatStrings [
          # Fixes https://github.com/direnv/direnv/issues/73
          "export_alias codium 'codium --profile Nix $@'"
          "\n"
          (pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              nixpkgs-fmt.enable = true;
            };
          }).shellHook
        ];
      };
    };
}
