{ config, config', lib, ... }: {
  programs.quadlets.quadlets =
    let
      dir = if config'.containers.gluetun ? dir && config'.containers.gluetun.dir != null then config'.containers.gluetun.dir else "${config'.dir.containers}/Gluetun";
    in
    [
      {
        name = "gluetun.container";
        content = ''
          [Container]
          AddCapability=NET_ADMIN
          AddDevice=/dev/net/tun:/dev/net/tun
          ContainerName=gluetun
          ${lib.optionalString (config'.containers.gluetun ? env && config'.containers.gluetun.env != null) "Environment=${lib.strings.concatStringsSep " " config'.containers.gluetun.env}"}
          ${lib.optionalString (config'.containers.gluetun ? envFiles && config'.containers.gluetun.envFiles != null) (lib.strings.concatStringsSep "\n" (lib.lists.map (n: "EnvironmentFile=${config.age.secrets.${n}.path}") config'.containers.gluetun.envFiles))}
          Image=docker.io/qmcgaw/gluetun
          Network=systemd-caddy
          PodmanArgs=--network-alias gluetun
          Volume=${dir}/config:/config

          [Unit]
          Wants=network-online.target
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
