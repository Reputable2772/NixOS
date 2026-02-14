{
  containers.caddy.services.ollama = "ollama:11434";

  programs.quadlets.quadlets."ollama.container" = {
    Container = {
      ContainerName = "ollama";
      Network = "systemd-caddy";
      Image = "docker.io/ollama/ollama:latest";
      Volume = [
        "data:/root/.ollama"
      ];
      AddDevice = "/dev/dri";
      GroupAdd = "keep-groups";
    };
  };
}
