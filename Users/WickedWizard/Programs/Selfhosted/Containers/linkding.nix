{
  containers.caddy.services.linkding = "linkding:9090";

  programs.quadlets.quadlets."linkding.volume" = {
    __options = {
      mkdir = false;
      appendEnv = false;
      appendEnvFiles = false;
      unitDefaults = true;
      addNetworkDependency = false;
      mapVolumes = false;
    };
    Unit.Description = "Linkding data Volume";
    Volume.VolumeName = "linkding";
    Service = {
      Type = "oneshot";
      Restart = "on-failure";
    };
  };

  programs.quadlets.quadlets."linkding.container" = {
    Container = {
      ContainerName = "linkding";
      Network = "systemd-caddy";
      Image = "docker.io/sissbruecker/linkding:latest";
      Volume = [
        "linkding.volume:/etc/linkding/data"
      ];
    };
  };
}
