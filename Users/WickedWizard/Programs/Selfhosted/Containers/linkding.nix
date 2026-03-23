{
  containers.caddy.services.linkding = "linkding:9090";

  programs.quadlets.quadlets."linkding.volume" = {
    Unit.Description = "Linkding data Volume";
    Volume.VolumeName = "linkding";
  };

  programs.quadlets.quadlets."linkding.container" = {
    Container = {
      ContainerName = "linkding";
      Network = "systemd-caddy";
      Image = "ghcr.io/sissbruecker/linkding:latest";
      Volume = [
        "linkding.volume:/etc/linkding/data"
      ];
    };
  };
}
