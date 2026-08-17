{
  config,
  lib,
  lib',
  ...
}:
{
  programs.home-manager.enable = true;

  secretspec = {
    files.selfhosted."Config/Secrets/selfhosted.age" = ../../Config/Secrets/selfhosted.age;
    config = {
      project = {
        name = "Home-Manager - ${config.home.username}";
        revision = "1.0";
      };

      providers.selfhosted = "age://Config/Secrets/selfhosted.age?identity=${config.home.homeDirectory}/.ssh/selfhosted&recipients=${config.home.homeDirectory}/.ssh/selfhosted.pub";

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
