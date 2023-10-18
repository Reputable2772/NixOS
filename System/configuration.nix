{ config, pkgs, ... }:
{
  time.timeZone = "Asia/Kolkata";

  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import
      (builtins.fetchTarball {
        url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
        sha256 = "This can be anything lol.";
      })
      {
        inherit pkgs;
      };
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  system.stateVersion = "23.05"; # Did you read the comment?

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 2d";
  };
}

