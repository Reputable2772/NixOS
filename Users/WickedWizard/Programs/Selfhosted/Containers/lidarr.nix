{ config, config', lib, sources, ... }:
let
  dir = if config'.containers.lidarr ? dir && config'.containers.lidarr.dir != null then config'.containers.lidarr.dir else "${config'.dir.containers}/Lidarr";
in
{
  home.file."${dir}/init.d/scripts_init.bash".source = "${sources.arr_scripts.src}/lidarr/scripts_init.bash";
  programs.quadlets.quadlets =
    [
      {
        name = "lidarr.container";
        content = ''
          [Container]
          ContainerName=lidarr
          Group=0
          Image=lscr.io/linuxserver/lidarr:latest
          Network=container:gluetun
          User=0
          Volume=${dir}/config:/config
          Volume=${dir}/services.d:/custom-services.d
          Volume=${dir}/init.d:/custom-cont-init.d
          Volume=${dir}/Library:/music
          Volume=${dir}:/imports
          Volume=${dir}/Downloads:/downloads

          ${lib.optionalString (config'.containers.lidarr ? env && config'.containers.lidarr.env != null) "Environment=${lib.strings.concatStringsSep " " config'.containers.lidarr.env}"}
          ${lib.optionalString (config'.containers.lidarr ? envFiles && config'.containers.lidarr.envFiles != null) (lib.strings.concatStringsSep "\n" (lib.lists.map (n: "EnvironmentFile=${config.age.secrets.${n}.path}") config'.containers.lidarr.envFiles))}

          # Arch wiki - https://wiki.archlinux.org/title/Podman#Quadlet
          UIDMap=1000:0:1
          UIDMap=0:1:1000
          UIDMap=1001:1001:64536

          [Unit]
          Wants=network-online.target
          Wants=gluetun.service
          After=network-online.target

          [Service]
          Restart=always
          TimeoutStartSec=300

          [Install]
          WantedBy=default.target
        '';
      }
    ];
}
