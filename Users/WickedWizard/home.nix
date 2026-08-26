{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./Programs
    ./Services

    ./flatpak.nix
  ];

  programs.mimeApps.enable = true;
  programs.mimeApps.useXdgMimeAppsDefaultApplications = true;
  programs.home-manager.enable = true;
  xdg.autostart.enable = true;

  home.activation.remove-backup-files =
    lib.hm.dag.entryBefore [ "writeBoundary" ]
      "(${pkgs.findutils}/bin/find ${config.home.homeDirectory}/.* -type f -name '*.backup.backup.backup' -exec ${pkgs.coreutils}/bin/rm -v {} \\; 2> /dev/null || exit 0)";

  secretspec = {
    files.wickedwizard."Config/Secrets/wickedwizard.age" =
      inputs.self + "/Config/Secrets/wickedwizard.age";
    config = {
      project = {
        name = "Home-Manager - ${config.home.username}";
        revision = "1.0";
      };

      providers.wickedwizard = "age://Config/Secrets/wickedwizard.age?identity=${config.home.homeDirectory}/.ssh/agenix&recipients=${config.home.homeDirectory}/.ssh/agenix.pub";

      profiles.wickedwizard = {
        defaults = {
          required = true;
          providers = [ "wickedwizard" ];
        };
      };
    };
  };
}
