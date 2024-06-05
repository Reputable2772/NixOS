{ config', ... }:
{
  programs.quadlets.quadlets = [
    {
      name = "qbittorrent.container";
      content = ''
        [Container]
        ContainerName=qbittorrent
        Environment=TZ=Asia/Kolkata WEBUI_PORT=8516 PUID=0 PGID=0
        Image=lscr.io/linuxserver/qbittorrent:latest
        Network=systemd-caddy
        PodmanArgs=--network-alias qbittorrent
        PublishPort=61851:61851
        PublishPort=61851:61851/udp
        Volume=${config'.config.dir.containers}qBittorrent/config:/config
        Volume=${config'.config.dir.containers}qBittorrent/VueTorrent:/themes/VueTorrent
        # Stays hardcoded, till I figure out a way to fix this
        Volume=/home/wickedwizard/Documents/Media/Downloads:/downloads

        # Arch wiki - https://wiki.archlinux.org/title/Podman#Quadlet
        UIDMap=1000:0:1
        UIDMap=0:1:1000
        UIDMap=1001:1001:64536

        [Service]
        Restart=always
        TimeoutStartSec=300

        [Unit]
        Wants=network-online.target
        After=network-online.target

        [Install]
        WantedBy=default.target
      '';
    }
  ];
}
