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
  secretspec.config.profiles.oracle-server = {
    ROOT_PASSWORD.description = "Hashed Password for root user";
    SELFHOSTED_PASSWORD.description = "Hashed Password for selfhosted user";
  };

  users.users.root.hashedPasswordFile =
    config.secretspec.secrets.profiles.oracle-server.ROOT_PASSWORD.plainPath;
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
    hashedPasswordFile = config.secretspec.secrets.profiles.oracle-server.SELFHOSTED_PASSWORD.plainPath;
    linger = true;
    openssh.authorizedKeys.keys = [ config'.users.selfhosted.secrets.ssh.key ];
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
    };

    extraSpecialArgs = {
      inherit inputs lib' sources;
    };
  };

  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
}
