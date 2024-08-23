{ config, config', lib, ... }:
let
  utils = import ./utils.nix { inherit config config' lib; };
in
{
  programs.quadlets.quadlets."gluetun.container" = lib.attrsets.recursiveUpdate
    {
      Container = {
        AddCapability = "NET_ADMIN";
        AddDevice = [
          "/dev/net/tun:/dev/net/tun"
        ];
        Image = "docker.io/qmcgaw/gluetun";
        Network = "systemd-caddy";
        Volume = utils.mapVolume "gluetun" [
          "config:/config"
        ];
      } // utils.appendEnv "gluetun";
    }
    (utils.containerDefaults "gluetun" "systemd-caddy");
}
