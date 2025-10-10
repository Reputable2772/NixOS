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
  containers.caddy.services.baikal = "baikal:80";

  programs.quadlets.quadlets."baikal.container" = lib.attrsets.recursiveUpdate {
    Container = {
      Image = "docker.io/ckulka/baikal:nginx";
      Volume = utils.mapVolume "baikal" [
        "config:/var/www/baikal/config"
        "data:/var/www/baikal/Specific"
      ];
    }
    // utils.appendEnv "baikal";
  } (utils.containerDefaults "baikal" "systemd-caddy");
}
