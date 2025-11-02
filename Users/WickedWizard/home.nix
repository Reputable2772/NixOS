{
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
    ./secrets.nix
  ];

  programs.mimeApps.enable = true;
  programs.mimeApps.useXdgMimeAppsDefaultApplications = true;
  programs.home-manager.enable = true;
  programs.autostart.enable = true;

  home.activation.remove-backup-files =
    lib.hm.dag.entryBefore [ "writeBoundary" ]
      "(${pkgs.findutils}/bin/find ${config.home.homeDirectory}/.* -type f -name '*.backup.backup.backup' -exec ${pkgs.coreutils}/bin/rm -v {} \\; 2> /dev/null || exit 0)";
}
