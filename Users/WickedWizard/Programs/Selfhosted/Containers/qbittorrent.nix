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
  containers.caddy.services.qbittorrent = "qbittorrent:8516";
  system-config.firewall.allowedTCPPorts = [ 61851 ];
  system-config.firewall.allowedUDPPorts = [ 61851 ];

  /**
    * UDP trackers literally do not work.
    * Can't find any relevant logs to debug.
    * Do not include uTP as a connection mode.
  */
  programs.quadlets.quadlets."qbittorrent.container" = lib.attrsets.recursiveUpdate {
    Container = {
      Image = "lscr.io/linuxserver/qbittorrent:latest";
      Network = "systemd-caddy";
      PublishPort = [
        "61851:61851"
        "61851:61851/udp"
      ];
      Volume = utils.mapVolume "qbittorrent" [
        "config:/config"
        "Downloads:/downloads"
      ];
      # Arch wiki - https://wiki.archlinux.org/title/Podman#Quadlet
    } // utils.appendEnv "qbittorrent";
  } (utils.containerDefaults "qbittorrent" "systemd-caddy");
}
