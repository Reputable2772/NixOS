{
  config,
  config',
  lib,
  ...
}:
let
  utils = import ./utils.nix { inherit config config' lib; };
in
{
  programs.quadlets.quadlets."syncthing.container" = lib.attrsets.recursiveUpdate {
    Container = {
      Image = "lscr.io/linuxserver/syncthing:latest";
      Network = "systemd-caddy";
      PublishPort = [
        "22000:22000/tcp"
        "22000:22000/udp"
        "21027:21027/udp"
      ];
      Volume =
        utils.mapVolume "syncthing" [
          "config:/config"
        ]
        ++ config'.containers.syncthing.custom.folders;
    } // utils.appendEnv "syncthing";
  } (utils.containerDefaults "syncthing" "systemd-caddy");
}
