{
  containers.caddy.services.baikal = "baikal:80";

  programs.quadlets.quadlets."baikal.container" = {
    Container = {
      ContainerName = "baikal";
      Network = "systemd-caddy";
      Image = "docker.io/ckulka/baikal:nginx";
      Volume = [
        "config:/var/www/baikal/config"
        "data:/var/www/baikal/Specific"
      ];
    };
  };
}
