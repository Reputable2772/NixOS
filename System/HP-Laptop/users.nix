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
  # Shell autocomplete
  environment.pathsToLink = [ "/share/zsh" ];

  age.secrets.wickedwizardPassword.file = ../../Config/wickedwizardPassword.age;
  age.secrets.rootPassword.file = ../../Config/rootPassword.age;

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
    ];
    shell = pkgs.zsh;
    hashedPasswordFile = config.age.secrets.wickedwizardPassword.path;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = lib.mkForce false;
    backupFileExtension = "backup.backup.backup";
    # users = lib.attrsets.mapAttrs
    # (n: v:
    users = {
      wickedwizard = {
        imports = [
          ../../Modules/Home-Manager
          ../../Users/WickedWizard/home.nix
          {
            home = {
              # username = n;
              # homeDirectory = v.home;
              stateVersion = "23.05";
            };
            _module.args.config' = config'.users.wickedwizard;
          }
        ];
      };
    };

    # (lib.attrsets.filterAttrs (n: v: v.isNormalUser && builtins.pathExists ../../Users/${v.description}/home.nix) config.users.users);
    extraSpecialArgs = {
      inherit inputs lib' sources;
    };
  };

  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
}
