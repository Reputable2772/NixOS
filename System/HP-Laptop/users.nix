{ config, config', pkgs, inputs, lib, lib', sources, ... }:
let
  inherit (inputs) home-manager;
  inherit (config') users;
in
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
    extraGroups = [ "wheel" "networkmanager" "input" "video" "render" ];
    shell = pkgs.zsh;
    hashedPasswordFile = config.age.secrets.wickedwizardPassword.path;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = lib.mkForce false;
    backupFileExtension = "bak";
    users = lib.attrsets.mapAttrs
      (n: v: {
        imports = [
          ../../Users/${v.description}/home.nix
          ../../Modules/Home-Manager
          {
            home = {
              username = n;
              homeDirectory = v.home;
              stateVersion = "23.05";
            };
          }
        ];
      })
      (lib.attrsets.filterAttrs (n: v: v.isNormalUser) config.users.users);
    extraSpecialArgs =
      let
        config' = users.wickedwizard;
      in
      {
        inherit inputs lib' sources config';
      };
  };

  imports = [
    home-manager.nixosModules.home-manager
  ];
}
