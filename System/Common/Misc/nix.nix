{ pkgs, ... }: {
  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 2d";
    };
    optimise = {
      automatic = true;
      dates = [ "daily" ];
    };
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "root" "@wheel" ];
      experimental-features = [ "flakes" "nix-command" ];
      substituters = [
        "https://spearman4157.cachix.org"
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
      ];
      trusted-public-keys = [
        "spearman4157.cachix.org-1:C5rIS9uufmlsdRIe9dEHSZVjxo9g8se+gjMdIeeEYfk="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      ];
    };
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      always-allow-substitutes = true
    '';

    /**
      Disable Nix channels.
      There is no need for setting NIX_PATH and the Flake registry, thanks to
      NixOS/nixpkgs#254405
     */
    channel.enable = false;
  };
}
