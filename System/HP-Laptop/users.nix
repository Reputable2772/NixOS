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
  users.users.maintenance = {
    isNormalUser = true;
    home = "/home/maintenance";
    # Description of all users should container their folder name.
    description = "maintenance";
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
    hashedPasswordFile = config.age.secrets.maintenancePassword.path;
    linger = true;
    openssh.authorizedKeys.keys = [ config'.users.maintenance.secrets.ssh.key ];
  };

  users.users.vishnu = {
    isNormalUser = true;
    home = "/home/vishnu";
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
      maintenance = {
        imports = [
          ../../Users/Maintenance/home.nix
          {
            home.stateVersion = "26.05";
            _module.args.config' = config'.users.maintenance;
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
