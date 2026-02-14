{
  config',
  lib,
  ...
}:
{
  containers.caddy.services.syncthing = "syncthing:8384";
  system-config.firewall = {
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [
      22000
      21027
    ];
  };

  programs.quadlets.quadlets."syncthing.container" = {
    Container = {
      ContainerName = "syncthing";
      Network = "systemd-caddy";
      Image = "lscr.io/linuxserver/syncthing:latest";
      PublishPort = [
        "22000:22000/tcp"
        "22000:22000/udp"
        "21027:21027/udp"
      ];
      Volume = [
        "config:/config"
      ]
      ++ lib.map (n: "${n}:noMap") config'.containers.syncthing.custom.folders;
    };
  };
}
