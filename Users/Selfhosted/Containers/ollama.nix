{
  containers.caddy.services.ollama = "ollama:11434";

  programs.quadlets.quadlets."ollama.container" = {
    __options.networkNameAlias = false;
    Container = {
      ContainerName = "ollama";
      GroupAdd = "keep-groups";
      Image = "docker.io/ollama/ollama:latest";
      Network = "systemd-caddy.network";
      Volume = [
        ":/root/.ollama"
      ];
      AddDevice = [
        "/dev/dri:/dev/dri"
      ];
    };
  };
}
