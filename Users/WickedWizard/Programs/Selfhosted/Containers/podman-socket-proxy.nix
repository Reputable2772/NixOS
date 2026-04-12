{
  config,
  lib,
  ...
}:
let
  inherit (lib) types;
  inherit (lib.options) mkOption;
  cfg = config.containers.podman-socket-proxy;
in
{
  options.containers.podman-socket-proxy = {
    allowedMethods = mkOption {
      type = types.attrsOf types.int;
      default = { };
      description = "Attrset of methods and their status.";
    };
  };

  config = {
    programs.quadlets.quadlets."podman-socket-proxy.container" = {
      Container = {
        ContainerName = "podman-socket-proxy";
        Network = "podman-socket";
        Image = "ghcr.io/linuxserver/socket-proxy:latest";
        Volume = [
          "$\{XDG_RUNTIME_DIR}/podman/podman.sock:/var/run/docker.sock:ro:noMap"
        ];
        Environment = lib.mapAttrsToList (n: v: "${n}=${toString v}") cfg.allowedMethods;
      };
    };

    programs.quadlets.quadlets."podman-socket.network" = {
      Network = {
        NetworkName = "podman-socket";
        Driver = "bridge";
        IPv6 = true;
      };
    };
  };
}
