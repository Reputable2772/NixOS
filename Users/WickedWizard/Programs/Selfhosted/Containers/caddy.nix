{ config', ... }: {
  programs.quadlets.quadlets = [
    {
      name = "caddy.container";
      content = ''
        [Container]
        ContainerName=caddy
        EnvironmentFile=${config'.dir.containers}/Caddy/.env
        Image=caddy
        Network=systemd-caddy
        PodmanArgs=--network-alias caddy
        PublishPort=80:80
        PublishPort=443:443
        PublishPort=2019:2019
        Volume=${config'.dir.containers}/Caddy/Caddyfile:/etc/caddy/Caddyfile
        Volume=${config'.dir.containers}/Caddy/config:/config
        Volume=${config'.dir.containers}/Caddy/data:/data

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
