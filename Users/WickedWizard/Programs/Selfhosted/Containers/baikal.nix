{ config, config', lib, ... }:
{
  programs.quadlets.quadlets =
    let
      dir = if config'.containers.baikal ? dir && config'.containers.baikal.dir != null then config'.containers.baikal.dir else config'.dir.containers;
    in
    [
      {
        name = "baikal.container";
        content = ''
          [Container]
          ContainerName=baikal
          Image=docker.io/ckulka/baikal:nginx
          Network=systemd-caddy
          PodmanArgs=--network-alias baikal
          ${lib.optionalString (config'.containers.baikal ? env && config'.containers.baikal.env != null) "Environment=${lib.strings.concatStringsSep " " config'.containers.baikal.env}"}
          ${lib.optionalString (config'.containers.baikal ? envFiles && config'.containers.baikal.envFiles != null) (lib.strings.concatStringsSep "\n" (lib.lists.map (n: "EnvironmentFile=${config.age.secrets.${n}.path}") config'.containers.baikal.envFiles))}
          Volume=${dir}/Baikal/config:/var/www/baikal/config
          Volume=${dir}/Baikal/data:/var/www/baikal/Specific

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
