{
  config,
  config',
  pkgs,
  inputs,
  lib,
  lib',
  sources,
  ...
}:
{
  # Needs to be set here or else shell won't work
  programs.zsh.enable = true;
  # Shell autocomplete for HM's ZSH.
  environment.pathsToLink = [ "/share/zsh" ];

  secretspec.config.profiles.lenovo-laptop = {
    ROOT_PASSWORD.description = "Hashed Password for root user";
    WICKEDWIZARD_PASSWORD.description = "Hashed Password for wickedwizard user";
    GUEST_PASSWORD.description = "Hashed Password for guest user";
  };

  users.mutableUsers = false;
  users.users.root.hashedPasswordFile =
    config.secretspec.secrets.profiles.lenovo-laptop.ROOT_PASSWORD.plainPath;
  users.users.wickedwizard = {
    isNormalUser = true;
    home = "/home/wickedwizard";
    # Description of all users should container their folder name.
    description = "WickedWizard";
    # Fixes https://github.com/GPUOpen-Drivers/AMDVLK/issues/310
    extraGroups = [
      "wheel"
      "networkmanager"
      "input"
      "video"
      "render"

      # Needed for virtualisation, Misc/virtualisation.nix
      "kvm"
      "libvirtd"
    ];
    shell = pkgs.zsh;
    hashedPasswordFile =
      config.secretspec.secrets.profiles.lenovo-laptop.WICKEDWIZARD_PASSWORD.plainPath;
  };

  users.users.guest = {
    isNormalUser = true;
    home = "/home/guest";
    description = "Guest";
    extraGroups = [
      "input"
      "video"
      "render"
    ];
    hashedPasswordFile = config.secretspec.secrets.profiles.lenovo-laptop.GUEST_PASSWORD.plainPath;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = lib.mkForce false;
    startAsUserService = true;
    backupFileExtension = "backup.backup.backup";
    verbose = true;
    sharedModules = [ ../../Modules/Home-Manager ];
    users = {
      wickedwizard = {
        imports = [
          ../../Users/WickedWizard/home.nix
          {
            home.stateVersion = "26.05";
            _module.args.config' = config'.users.wickedwizard;
          }
        ];
      };

      guest = {
        imports = [
          ../../Users/Guest/home.nix
          {
            home.stateVersion = "26.05";
            _module.args.config' = config'.users.guest;
          }
        ];
      };
    };

    extraSpecialArgs = {
      inherit inputs lib' sources;
    };
  };

  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
}
