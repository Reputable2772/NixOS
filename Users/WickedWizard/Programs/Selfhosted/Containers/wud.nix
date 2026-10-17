{ config, ... }: {
  containers.caddy.services.wud = "wud:3000";
  containers.podman-socket-proxy.allowedMethods = {
    CONTAINERS = 1;
    ALLOW_START = 1;
    ALLOW_STOP = 1;
    IMAGES = 1;
    POST = 0;
  };

  secretspec.config = {
    profiles.wickedwizard = {
      WUD_TRIGGER_NTFY_UPDATENOTIF_TOPIC.description = "The ntfy url to be triggered on container updates";
      WUD_AUTH_BASIC_MAIN_USER.description = "Login Username for WUD";
      # https://getwud.github.io/wud/#/configuration/
      WUD_AUTH_BASIC_MAIN_HASH.description = "Hashed login Password for WUD";
    };
    scopes.wud.secrets = [
      "WUD_TRIGGER_NTFY_UPDATENOTIF_TOPIC"
      "WUD_AUTH_BASIC_MAIN_USER"
      "WUD_AUTH_BASIC_MAIN_HASH"
    ];
  };

  programs.quadlets.quadlets."wud.container" = {
    Container = {
      ContainerName = "wud";
      Image = "ghcr.io/getwud/wud:latest";
      Network = [
        "systemd-caddy.network"
        "podman-socket.network"
      ];
      EnvironmentFile = config.secretspec.secrets.scopes.wud.path;
      Environment = [
        # Do not name watchers as DOCKER
        # getwud/wud#1282
        "WUD_WATCHER_LOCAL_HOST=podman-socket-proxy"
        "WUD_WATCHER_LOCAL_PORT=2375"
        "WUD_WATCHER_LOCAL_WATCHEVENTS=true"
        "WUD_WATCHER_LOCAL_WATCHATSTART=true"
        "WUD_WATCHER_LOCAL_WATCHBYDEFAULT=true"

        "WUD_REGISTRY_CUSTOM_N8N_URL=https://docker.n8n.io"
      ];
    };
  };
}
