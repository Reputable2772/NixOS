{ config, config', lib, ... }:
{
  programs.quadlets.quadlets =
    let
      dir = if config'.containers.qbittorrent ? dir && config'.containers.qbittorrent.dir != null then config'.containers.qbittorrent.dir else "${config'.dir.containers}/qBittorrent";
    in
    [
      {
        name = "qbittorrent.container";
        content = ''
          [Container]
          ContainerName=qbittorrent
          ${lib.optionalString (config'.containers.qbittorrent ? env && config'.containers.qbittorrent.env != null) "Environment=${lib.strings.concatStringsSep " " config'.containers.qbittorrent.env}"}
          ${lib.optionalString (config'.containers.qbittorrent ? envFiles && config'.containers.qbittorrent.envFiles != null) (lib.strings.concatStringsSep "\n" (lib.lists.map (n: "EnvironmentFile=${config.age.secrets.${n}.path}") config'.containers.qbittorrent.envFiles))}
          Image=lscr.io/linuxserver/qbittorrent:latest
          Network=systemd-caddy
          PodmanArgs=--network-alias qbittorrent
          PublishPort=61851:61851
          PublishPort=61851:61851/udp
          Volume=${dir}/config:/config
          Volume=${dir}/VueTorrent:/themes/VueTorrent
          Volume=${dir}/Downloads:/downloads

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
