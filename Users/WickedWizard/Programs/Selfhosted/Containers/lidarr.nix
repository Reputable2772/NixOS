{
  config,
  config',
  lib,
  ...
}:
/**
  Gluetun is only required when using Deezer a source, since
  it isn't available here.

  Look at commits b2c4e33 or before as a guide on how
  to use gluetun with lidarr.
*/
let
  utils = import ./utils.nix { inherit config config' lib; };
in
{

  containers.caddy.services.lidarr = "lidarr:8686";

  programs.quadlets.quadlets."lidarr.container" = (
    lib.attrsets.recursiveUpdate {
      Container = {
        ContainerName = "lidarr";
        Group = 0;
        Image = "ghcr.io/linuxserver-labs/prarr:lidarr-plugins";
        User = 0;
        Volume = [
          config'.containers.lidarr.custom.music.libraryPath
          config'.containers.qbittorrent.custom.downloadPath
        ]
        ++ utils.mapVolume "lidarr" [
          "config:/config"
          "Imports:/imports"
        ];
      }
      // utils.appendEnv "lidarr";
    } (utils.containerDefaults "lidarr" "systemd-caddy")
  );
}
