{
  config,
  lib,
  lib',
  ...
}:
{
  programs.home-manager.enable = true;

  secretspec = {
    flakeRootDir = ../..;
    config = {
      project = {
        name = "Home-Manager - ${config.home.username}";
        revision = "1.0";
      };

      providers.selfhosted = "age://Config/Secrets/selfhosted.age?identity=/home/wickedwizard/.ssh/selfhosted&recipients=/home/wickedwizard/.ssh/selfhosted.pub";

      profiles.selfhosted = {
        defaults = {
          required = true;
          providers = [ "selfhosted" ];
        };
      };
    };
  };
  programs.quadlets.enable = true;

  imports = [
    ./bottom.nix
    ./ip-update.nix
    ./tmux.nix
  ]
  ++ (lib.attrValues (lib'.readDirectory ./Containers true));
}
