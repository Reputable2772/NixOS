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
  containers.caddy.extraConfig = [
    ''
      {env.DOMAIN} {env.EXTERNAL_DOMAIN} {
        import default

        reverse_proxy homepage:3000
      }
    ''
  ];

  programs.quadlets.quadlets."homepage.container" = lib.attrsets.recursiveUpdate {
    Container = {
      Image = "ghcr.io/gethomepage/homepage:latest";
      Volume = utils.mapVolume "homepage" [
        "config:/app/config"
      ];
    } // utils.appendEnv "homepage";
  } (utils.containerDefaults "homepage" "systemd-caddy");
}
