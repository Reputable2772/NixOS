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
      Volume = utils.mapVolume "navidrome" [
        "data:/data"
        # TODO: Symlink this to $HOME/Documents/Music
        "music:/music:ro"
      ];
    } // utils.appendEnv "navidrome";
  } (utils.containerDefaults "navidrome" "systemd-caddy");
}
