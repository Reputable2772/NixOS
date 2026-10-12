{
  config,
  config',
  inputs,
  pkgs,
  lib,
  lib',
  sources,
  ...
}:
{
  users.mutableUsers = false;
  secretspec.config.profiles.astra-1 = {
    ROOT_PASSWORD.description = "Hashed Password for root user";
    ASTRA_1_PASSWORD.description = "Hashed Password for astra-1 user";
  };

  users.users.root.hashedPasswordFile =
    config.secretspec.secrets.profiles.astra-1.ROOT_PASSWORD.plainPath;
  users.users.astra-1 = {
    isNormalUser = true;
    home = "/home/astra-1";
    # Description of all users should container their folder name.
    description = "astra-1";
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
    hashedPasswordFile = config.secretspec.secrets.profiles.astra-1.ASTRA_1_PASSWORD.plainPath;
    linger = true;
    openssh.authorizedKeys.keys = [ config'.users.astra-1.secrets.ssh.key ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = lib.mkForce false;
    startAsUserService = true;
    backupFileExtension = "backup.backup.backup";
    backupCommand = "${pkgs.trash-cli}/bin/trash";
    verbose = true;
    sharedModules = [ ../../Modules/Home-Manager ];
    users = {
      astra-1 = {
        imports = [
          ../../Users/Astra-1/home.nix
          {
            home.stateVersion = "26.05";
            _module.args.config' = config'.users.astra-1;
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
