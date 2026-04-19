{
  containers.caddy.services.baikal = "baikal:80";

  programs.quadlets.quadlets."baikal.container" = {
    Container = {
      ContainerName = "baikal";
      Network = "systemd-caddy.network";
      Image = "docker.io/ckulka/baikal:nginx";
      Label = [ "wud.watch.digest=true" ];
      Volume = [
        "config:/var/www/baikal/config"
        "data:/var/www/baikal/Specific"
      ];
    };
  };
}
