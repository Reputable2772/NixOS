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

  age.secrets.wickedwizardPassword.file = ../../Config/wickedwizardPassword.age;
  age.secrets.rootPassword.file = ../../Config/rootPassword.age;
  age.secrets.guestPassword.file = ../../Config/guestPassword.age;

  users.mutableUsers = false;
  users.users.root.hashedPasswordFile = config.age.secrets.rootPassword.path;
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
    hashedPasswordFile = config.age.secrets.wickedwizardPassword.path;
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
    hashedPasswordFile = config.age.secrets.guestPassword.path;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = lib.mkForce false;
    backupFileExtension = "backup.backup.backup";
    verbose = true;
    sharedModules = [ ../../Modules/Home-Manager ];
    users = {
      wickedwizard = {
        imports = [
          ../../Modules/Home-Manager
          ../../Users/WickedWizard/home.nix
          {
            home.stateVersion = "23.05";
            _module.args.config' = config'.users.wickedwizard;
          }
        ];
      };

      guest = {
        imports = [
          ../../Modules/Home-Manager
          ../../Users/Guest/home.nix
          {
            home.stateVersion = "23.05";
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
