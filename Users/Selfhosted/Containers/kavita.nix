{
  containers.caddy.services.kavita = "kavita:5000";

  programs.quadlets.quadlets."kavita.container" = {
    Container = {
      ContainerName = "kavita";
      Network = "systemd-caddy.network";
      Image = "lscr.io/linuxserver/kavita:latest";
      Volume = [
        "config:/config"
        "data:/data"
      ];
    };
  };
}
