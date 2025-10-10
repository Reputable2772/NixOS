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
  containers.caddy.services.syncthing = "syncthing:8384";
  system-config.firewall = {
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [
      22000
      21027
    ];
  };

  programs.quadlets.quadlets."syncthing.container" = lib.attrsets.recursiveUpdate {
    Container = {
      Image = "lscr.io/linuxserver/syncthing:latest";
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
    }
    // utils.appendEnv "syncthing";
  } (utils.containerDefaults "syncthing" "systemd-caddy");
}
