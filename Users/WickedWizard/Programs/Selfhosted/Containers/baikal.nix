{ config', ... }:
{
  programs.quadlets.quadlets = [
    {
      name = "baikal.container";
      content = ''
        [Container]
        ContainerName=baikal
        Image=docker.io/ckulka/baikal:nginx
        Network=systemd-caddy
        PodmanArgs=--network-alias baikal
        Volume=${config'.config.dir.containers}/Baikal/baikal/config:/var/www/baikal/config
        Volume=${config'.config.dir.containers}/Baikal/baikal/data:/var/www/baikal/Specific

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
