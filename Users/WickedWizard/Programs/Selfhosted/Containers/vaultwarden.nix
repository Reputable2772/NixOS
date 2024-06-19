{ config, config', lib, ... }:
{
  programs.quadlets.quadlets =
    let
      dir = if config'.containers.vaultwarden ? dir && config'.containers.vaultwarden.dir != null then config'.containers.vaultwarden.dir else "${config'.dir.containers}/Vaultwarden";
    in
    [
      {
        name = "vaultwarden.container";
        content = ''
          # vaultwarden.container
          [Container]
          ContainerName=vaultwarden
          ${lib.optionalString (config'.containers.vaultwarden ? env && config'.containers.vaultwarden.env != null) "Environment=${lib.strings.concatStringsSep " " config'.containers.vaultwarden.env}"}
          ${lib.optionalString (config'.containers.vaultwarden ? envFiles && config'.containers.vaultwarden.envFiles != null) (lib.strings.concatStringsSep "\n" (lib.lists.map (n: "EnvironmentFile=${config.age.secrets.${n}.path}") config'.containers.vaultwarden.envFiles))}
          Image=docker.io/vaultwarden/server:latest
          Network=systemd-caddy
          PodmanArgs=--network-alias vaultwarden
          Volume=${dir}:/data

          [Service]
          Restart=on-failure
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
