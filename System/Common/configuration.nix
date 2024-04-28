{ pkgs, inputs, ... }: {
  time.timeZone = "Asia/Kolkata";

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-old --delete-older-than 2d";
    };
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "root" "@wheel" ];
      experimental-features = [ "flakes" "nix-command" ];
      substituters = [
        "https://spearman4157.cachix.org"
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://numtide.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
      ];
      trusted-public-keys = [
        "spearman4157.cachix.org-1:C5rIS9uufmlsdRIe9dEHSZVjxo9g8se+gjMdIeeEYfk="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      ];
    };
    package = pkgs.nixVersions.nix_2_21;
    extraOptions = ''
      always-allow-substitutes = true
    '';
  };

  imports = [
    ../../Modules/System
  ];

  system.stateVersion = "23.05";
}

