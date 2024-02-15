{ config, pkgs, inputs, ... }:
{
  time.timeZone = "Asia/Kolkata";

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-generations --delete-older-than 2d";
    };
    settings.experimental-features = [ "flakes" "nix-command" ];
    registry.nixpkgs.flake = inputs.nixpkgs;
  };

  system.stateVersion = "23.05";
}

