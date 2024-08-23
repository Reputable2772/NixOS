{ config, config', lib, ... }:
let
  utils = import ./utils.nix { inherit config config' lib; };
in
{
  programs.quadlets.quadlets."vaultwarden.container" = lib.attrsets.recursiveUpdate
    {
      Container = {
        Image = "docker.io/vaultwarden/server:latest";
        Network = "systemd-caddy";
        Volume = utils.mapVolume "vaultwarden" [
          ":/data"
        ];
      } // utils.appendEnv "vaultwarden";
    }
    (utils.containerDefaults "vaultwarden" "systemd-caddy");
}
