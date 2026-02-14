{
  containers.caddy.services.linkding = "linkding:9090";

  programs.quadlets.quadlets."linkding.container" = {
    Container = {
      ContainerName = "linkding";
      Network = "systemd-caddy";
      Image = "docker.io/sissbruecker/linkding:latest";
      Volume = [
        "data:/etc/linkding/data"
      ];
    };
  };
}
