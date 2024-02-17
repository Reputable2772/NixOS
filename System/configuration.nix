{ config, pkgs, ... }:
{
  time.timeZone = "Asia/Kolkata";

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # inputs.nixpkgs.overlays = (inputs.nixpkgs.overlays or [])  ++ import ../Overlays;

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
    # registry.nixpkgs.flake = inputs.nixpkgs;
  };

  system.stateVersion = "23.05";
}

