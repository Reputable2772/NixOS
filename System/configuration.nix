{ config, pkgs, ... }:
{
  time.timeZone = "Asia/Kolkata";

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # TODO: Fix this.
  # inputs.nixpkgs.overlays = (inputs.nixpkgs.overlays or [])  ++ import ../Overlays;
  # nix.registry.nixpkgs.flake = inputs.nixpkgs;

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-generations --delete-older-than 2d";
    };
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "root" "@wheel" ];
    };
  };

  system.stateVersion = "23.05";
}

