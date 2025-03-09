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
  programs.quadlets.quadlets."linkding.container" = lib.attrsets.recursiveUpdate {
    Container = {
      Image = "docker.io/sissbruecker/linkding:latest";
      Volume = utils.mapVolume "linkding" [
        "data:/etc/linkding/data"
      ];
    } // utils.appendEnv "linkding";
  } (utils.containerDefaults "linkding" "systemd-caddy");
}
