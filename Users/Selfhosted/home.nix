{
  programs.home-manager.enable = true;

  imports = [
    ./bottom.nix
    ./tmux.nix
  ];

  system-config.firewall.allowedTCPPorts = [ 11434 ];

  programs.quadlets = {
    enable = true;
    quadlets = {
      # "minecraft.container" = {
      #   __options.networkNameAlias = false;
      #   Container = {
      #     ContainerName = "minecraft";
      #     Image = "docker.io/itzg/minecraft-server";
      #     PublishPort = [
      #       "12365:25565"
      #     ];
      #     Volume = [
      #       "data:/data"
      #     ];
      #   };
      # };

      "ollama.container" = {
        __options.networkNameAlias = false;
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
    };
  };
}
