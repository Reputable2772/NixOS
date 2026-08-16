{ config, ... }: {
  programs.home-manager.enable = true;

  secretspec = {
    flakeRootDir = ../..;
    config = {
      project = {
        name = "Home-Manager - ${config.home.username}";
        revision = "1.0";
      };

      providers.maintenance = "age://Config/Secrets/maintenance.age?identity=${config.home.homeDirectory}/.ssh/maintenance&recipients=${config.home.homeDirectory}/.ssh/maintenance.pub";

      profiles.maintenance = {
        defaults = {
          required = true;
          providers = [ "maintenance" ];
        };
      };
    };
  };

  imports = [
    ./bottom.nix
    ./ip-update.nix
    ./tmux.nix
  ];
}
