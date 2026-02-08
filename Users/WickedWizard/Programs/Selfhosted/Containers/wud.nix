{
  config,
  config',
  lib,
  ...
}:
let
  utils = import ./utils.nix { inherit config config' lib; };
in
{
  containers.caddy.services.wud = "wud:3000";
  containers.podman-socket-proxy.allowedMethods = {
    CONTAINERS = 1;
    ALLOW_START = 1;
    ALLOW_STOP = 1;
    IMAGES = 1;
    POST = 0;
  };

  programs.quadlets.quadlets."wud.container" =
    lib.attrsets.recursiveUpdate (utils.containerDefaults "wud" "systemd-caddy")
      {
        Container = utils.appendEnv "wud" // {
          Image = "ghcr.io/getwud/wud:main";
          Network = [
            "systemd-caddy"
            "podman-socket"
          ];
          Environment = [
            "WUD_WATCHER_DOCKER_HOST=podman-socket-proxy"
            "WUD_WATCHER_DOCKER_PORT=2375"
            "WUD_WATCHER_DOCKER_SOCKET=tcp://podman-socket-proxy"
            "WUD_WATCHER_DOCKER_WATCHEVENTS=true"
            "WUD_WATCHER_DOCKER_WATCHATSTART=true"
            "WUD_WATCHER_DOCKER_WATCHBYDEFAULT=true"
            "WUD_WATCHER_DOCKER_WATCHALL=true"
          ];
        };
      };
}
