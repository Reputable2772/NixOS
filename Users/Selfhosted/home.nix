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

      "freellmapi.container" = {
        __options.networkNameAlias = false;
        Container = {
          ContainerName = "freellmapi";
          Image = "ghcr.io/tashfeenahmed/freellmapi:latest";
          PublishPort = [
            "3001:3001"
          ];
          Volume = [
            ":/app/server/data"
          ];

          HealthCmd = ''
            node -e "fetch('http://127.0.0.1:3001/api/ping').then((res)=>{if(!res.ok)process.exit(1)}).catch(()=>process.exit(1))"
          '';
          HealthInterval = "30s";
          HealthTimeout = "5s";
          HealthStartPeriod = "15s";
          HealthRetries = 3;
        };
      };
    };
  };
}
