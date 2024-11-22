{
  config,
  config',
  lib,
  sources,
  ...
}:
let
  utils = import ./utils.nix { inherit config config' lib; };
in
{
  programs.quadlets.quadlets."lidarr.container" =
    (lib.attrsets.recursiveUpdate
      {
        Container = {
          ContainerName = "lidarr";
          Group = 0;
          Image = "lscr.io/linuxserver/lidarr:latest";
          Network = "container:gluetun";
          User = 0;
          Volume =
            [
              "${sources.arr_scripts.src}/lidarr/scripts_init.bash:/custom-cont-init.d/scripts_init.bash:ro"
            ]
            ++ utils.mapVolume "lidarr" [
              "init.d/custom-cont-init.d"
              "config:/config"
              "Library:/music"
              "Imports:/imports"
              "Downloads:/downloads"
            ];
          # Arch wiki - https://wiki.archlinux.org/title/Podman#Quadlet
          UIDMap = [
            "1000:0:1"
            "0:1:1000"
            "1001:1001:64536"
          ];
        } // utils.appendEnv "lidarr";
      }
      # Cannot use utils.containerDefaults, since it sets --network-alias,
      # which is not applicable for this networking.
      utils.defaults
    )
    // {
      # Give higher preference to this on merging, over network-online.target since gluetun service itself
      # fulfills that wants anyway.
      Unit.Requires = [ "gluetun.service" ];
    };
}
