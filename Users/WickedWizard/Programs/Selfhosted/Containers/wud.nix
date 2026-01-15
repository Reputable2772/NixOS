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

  programs.quadlets.quadlets."wud.container" = lib.attrsets.recursiveUpdate {
    Container = {
      Image = "ghcr.io/getwud/wud:main";
      Volume = [
        "/run/user/1000/podman/podman.sock:/var/run/docker.sock"
      ];
    }
    // utils.appendEnv "wud";
  } (utils.containerDefaults "wud" "systemd-caddy");
}
