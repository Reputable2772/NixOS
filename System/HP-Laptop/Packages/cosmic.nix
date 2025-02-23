{ inputs, ... }:
let
  # Check if nixpkgs.follows = "nixos-cosmic/nixpkgs"
  cosmic-enabled = inputs.nixpkgs == inputs.nixos-cosmic.inputs.nixpkgs;
in
{
  imports = [
    inputs.nixos-cosmic.nixosModules.default
  ];

  nix.settings = {
    substituters = [ "https://cosmic.cachix.org/" ];
    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  };

  # Uncomment `nixpkgs.follows` line in flake.nix to enable cosmic.
  services.desktopManager.cosmic.enable = cosmic-enabled;
  services.displayManager.cosmic-greeter.enable = cosmic-enabled;
}
