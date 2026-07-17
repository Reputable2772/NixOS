{
  programs.home-manager.enable = true;

  programs.quadlets = {
    quadlets = {
      "minecraft.container" = {
        Container = {
          ContainerName = "minecraft";
          Image = "docker.io/itzg/minecraft-server";
          PublishPort = [
            "12365:25565"
          ];
          Volume = [
            "data:/data"
          ];
        };
      };

      "ollama.container" = {
        Container = {
          ContainerName = "ollama";
          GroupAdd = "keep-groups";
          Image = "docker.io/ollama/ollama:latest";
          PublishPort = [
            "11434:11434"
          ];
          Volume = [
            ":/root/.ollama"
          ];
          AddDevice = [
            "/dev/dri:/dev/dri"
          ];
        };
      };

      "ddns-updater.container" = {
        Container = {
          ContainerName = "ddns-updater";
          Image = "docker.io/favonia/cloudflare-ddns:latest";
          Network = "host";
          User = "1000:1000";

          ReadOnly = true;
          SecurityLabelDisable = true;
          NoNewPrivileges = true;
          DropCapability = "all";
        };
      };
    };
  };
}
