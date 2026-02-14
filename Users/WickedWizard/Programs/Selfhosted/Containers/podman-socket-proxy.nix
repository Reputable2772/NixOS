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
        Image = "tecnativa/docker-socket-proxy:latest";
        Volume = [
          "/run/user/1000/podman/podman.sock:/var/run/docker.sock:ro:noMap"
        ];
        Environment = lib.mapAttrsToList (n: v: "${n}=${toString v}") cfg.allowedMethods;
      };
    };

    programs.quadlets.quadlets."podman-socket.network" = {
      __options = {
        mkdir = false;
        appendEnv = false;
        appendEnvFiles = false;
        unitDefaults = true;
        addNetworkDependency = false;
        mapVolumes = false;
      };
      Network = {
        NetworkName = "podman-socket";
        Driver = "bridge";
        IPv6 = true;
      };
    };
  };
}
