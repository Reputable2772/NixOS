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

  /**
    * Do not turn on
    * Reannounce to all trackers when IP or port changed:
    * in Qbittorrent advanced settings. This stops UDP
    * trackers from completely functioning.
  */
  programs.quadlets.quadlets."qbittorrent.container" = lib.attrsets.recursiveUpdate {
    Container = {
      Image = "lscr.io/linuxserver/qbittorrent:latest";
      PublishPort = [
        "61851:61851/tcp"
        "61851:61851/udp"
      ];
      Volume = utils.mapVolume "qbittorrent" [
        "config:/config"
        "VueTorrent:/themes/VueTorrent"
        "Downloads:/downloads"
      ];
      # Arch wiki - https://wiki.archlinux.org/title/Podman#Quadlet
      UIDMap = [
        "1000:0:1"
        "0:1:1000"
        "1001:1001:64536"
      ];
    } // utils.appendEnv "qbittorrent";
  } (utils.containerDefaults "qbittorrent" "systemd-caddy");
}
