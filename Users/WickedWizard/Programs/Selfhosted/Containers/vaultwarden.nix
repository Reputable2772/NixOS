{ config, config', ... }:
let
  cfg = config'.users.${config.home.username};
in
{
  programs.quadlets.quadlets = [
    {
      name = "vaultwarden.container";
      content = ''
        # vaultwarden.container
        [Container]
        ContainerName=vaultwarden
        EnvironmentFile=${cfg.config.dir.containers}/Vaultwarden/.env
        Image=docker.io/vaultwarden/server:latest
        Network=systemd-caddy
        PodmanArgs=--network-alias vaultwarden
        Volume=${cfg.config.dir.containers}/Vaultwarden/vaultwarden:/data

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
