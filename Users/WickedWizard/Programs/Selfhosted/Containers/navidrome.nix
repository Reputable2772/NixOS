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
  programs.quadlets.quadlets."navidrome.container" = lib.attrsets.recursiveUpdate {
    Container = {
      Image = "deluan/navidrome:latest";
      Network = "systemd-caddy";
      Volume = utils.mapVolume "navidrome" [
        "data:/data"
        "music:/music:ro"
      ];
    } // utils.appendEnv "navidrome";
  } (utils.containerDefaults "navidrome" "systemd-caddy");
}
