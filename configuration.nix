{ config, pkgs, ... }:
{
  time.timeZone = "Asia/Kolkata";

  nix.settings.experimental-features = [ "flakes" "nix-command" ];
  nix.settings.trusted-users = [ "wickedwizard" "shuba" ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "beeper"
    "spotify"
    "skypeforlinux"
    "steam"
    "steam-original"
    "steam-run"
  ];

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

  # Needs to be set here or else shell won't work
  programs.zsh.enable = true;

  users.users.wickedwizard = {
    isNormalUser = true;
    home = "/home/wickedwizard";
    description = "WickedWizard";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  users.users.shuba = {
    isNormalUser = true;
    home = "/home/shuba";
    description = "Shuba";
    extraGroups = [ "networkmanager" ];
  };

  system.stateVersion = "23.05"; # Did you read the comment?

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 2d";
  };

  imports =
    [
      ./System
    ];
}

