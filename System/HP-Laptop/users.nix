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
  users.mutableUsers = false;
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

  users.users.guest = {
    isNormalUser = true;
    home = "/home/guest";
    description = "Guest";
    extraGroups = [
      "input"
      "video"
      "render"
      "networkmanager"
    ];
    hashedPasswordFile = config.age.secrets.guestPassword.path;
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
