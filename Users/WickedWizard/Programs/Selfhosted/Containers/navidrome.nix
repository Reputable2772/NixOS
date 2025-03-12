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
  containers.caddy.services.navidrome = "navidrome:4533";

  programs.quadlets.quadlets."navidrome.container" = lib.attrsets.recursiveUpdate {
    Container = {
      Image = "deluan/navidrome:latest";
      Volume =
        [ config'.containers.navidrome.custom.music.libraryPath ]
        ++ utils.mapVolume "navidrome" [
          "data:/data"
        ];
    } // utils.appendEnv "navidrome";
  } (utils.containerDefaults "navidrome" "systemd-caddy");
}
