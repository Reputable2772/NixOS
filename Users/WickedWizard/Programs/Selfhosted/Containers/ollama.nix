{
  containers.caddy.services.ollama = "ollama:11434";

  programs.quadlets.quadlets."ollama.container" = {
    Container = {
      ContainerName = "ollama";
      Network = "systemd-caddy.network";
      Image = "docker.io/ollama/ollama:latest";
      Volume = [
        "data:/root/.ollama"
      ];
      Label = [ "wud.watch.digest=true" ];
      # AddDevice = "/dev/dri";
      GroupAdd = "keep-groups";
    };
  };
}
