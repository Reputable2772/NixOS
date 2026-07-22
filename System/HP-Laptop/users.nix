{
  config,
  config',
  inputs,
  lib,
  lib',
  sources,
  ...
}:
{
  users.mutableUsers = true;
  users.users.root.hashedPasswordFile = config.age.secrets.rootPassword.path;
  users.users.selfhosted = {
    isNormalUser = true;
    home = "/home/selfhosted";
    # Description of all users should container their folder name.
    description = "selfhosted";
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
    # shell = pkgs.zsh;
    hashedPasswordFile = config.age.secrets.selfhostedPassword.path;
    linger = true;
  };

  users.users.vishnu = {
    isNormalUser = true;
    home = "/home/guest";
    description = "Vishnu";
    extraGroups = [
      "input"
      "video"
      "render"
      "networkmanager"
    ];
    initialHashedPassword = "$y$j9T$T.1e5vo2lNood2mmpYVp8.$71pkBSAtLxcrN7qDsSuvB.40pmc7nC1tO0CrvL402xC";
    # hashedPasswordFile = config.age.secrets.guestPassword.path;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = lib.mkForce false;
    startAsUserService = true;
    backupFileExtension = "backup.backup.backup";
    verbose = true;
    sharedModules = [ ../../Modules/Home-Manager ];
    users = {
      selfhosted = {
        imports = [
          ../../Users/Selfhosted/home.nix
          {
            home.stateVersion = "26.05";
            _module.args.config' = config'.users.selfhosted;
          }
        ];
      };

      vishnu = {
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
