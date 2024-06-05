{ config', ... }:
{
  programs.quadlets.quadlets = [
    {
      name = "vaultwarden.container";
      content = ''
        # vaultwarden.container
        [Container]
        ContainerName=vaultwarden
        EnvironmentFile=${config'.dir.containers}/Vaultwarden/.env
        Image=docker.io/vaultwarden/server:latest
        Network=systemd-caddy
        PodmanArgs=--network-alias vaultwarden
        Volume=${config'.dir.containers}/Vaultwarden/vaultwarden:/data

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
