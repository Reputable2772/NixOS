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
