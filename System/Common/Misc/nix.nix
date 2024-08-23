{ config, lib, pkgs, inputs, ... }: {
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
      # Fixes NixOS/nix#9574
      nix-path = config.nix.nixPath;
      substituters = [
        "https://spearman4157.cachix.org?priority=10"
        "https://cache.nixos.org/?priority=20"
        "https://nix-community.cachix.org?priority=30"
        "https://nixpkgs-wayland.cachix.org?priority=40"
      ];
      trusted-public-keys = [
        "spearman4157.cachix.org-1:C5rIS9uufmlsdRIe9dEHSZVjxo9g8se+gjMdIeeEYfk="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
    package = pkgs.lix;
    channel.enable = false;
    extraOptions = ''
      flake-registry =
      always-allow-substitutes = true
    '';

    /**
      Map the registry so that it has every flake input in it.
      Also make sure the flake contains every input path in it.
      Set nix.settings.nix-path manually as well, see above
     */
    registry = lib.mapAttrs (_: value: { flake = value; }) (lib.filterAttrs (n: v: n != "self") inputs);
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  };
}
