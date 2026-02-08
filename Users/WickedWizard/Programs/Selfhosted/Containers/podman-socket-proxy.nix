{
  config,
  config',
  lib,
  ...
}:
let
  utils = import ./utils.nix { inherit config config' lib; };

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
    programs.quadlets.quadlets."podman-socket-proxy.container" = lib.attrsets.recursiveUpdate {
      Container = utils.appendEnv "podman-socket-proxy" // {
        Image = "tecnativa/docker-socket-proxy:latest";
        Volume = [
          "/run/user/1000/podman/podman.sock:/var/run/docker.sock:ro"
        ];
        Environment = lib.mapAttrsToList (n: v: "${n}=${toString v}") cfg.allowedMethods;
      };
    } (utils.containerDefaults "podman-socket-proxy" "podman-socket");

    programs.quadlets.quadlets."podman-socket.network" = {
      Network = {
        NetworkName = "podman-socket";
        Driver = "bridge";
        IPv6 = true;
      };
    }
    // utils.defaults
    // {
      Service = {
        Restart = "on-failure";
        TimeoutStartSec = 300;
      };
    };
  };
}
