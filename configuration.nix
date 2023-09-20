{ config, pkgs, ... }:
{
  imports =
    [
      ./System
    ];

  time.timeZone = "Asia/Kolkata";

  nix.settings.experimental-features = [ "flakes" "nix-command" ];
  nix.settings.trusted-users = [ "wickedwizard" "shuba" ];
  nixpkgs.config.allowUnfree = true;

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings = { dns_enabled = true; ipv6 = true; };
    };
    containers.enable = true;
    containers.storage.settings = {
      storage = {
        driver = "overlay";
        runroot = "/run/containers/storage";
        graphroot = "/var/lib/containers/storage";
        rootless_storage_path = "/tmp/containers-$USER";
        options.overlay.mountopt = "nodev,metacopy=on";
      };
    };

    oci-containers.backend = "podman";
    waydroid.enable = true;
  };

  programs.gamemode.enable = true;
  programs.gnupg.agent.enable = true;

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

  services.fwupd.enable = true;

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
}

