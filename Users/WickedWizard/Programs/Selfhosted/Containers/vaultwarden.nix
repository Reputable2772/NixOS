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
  containers.caddy.servicesExtraConfig.vaultwarden = ''
    @admin {
      path /admin*
      not remote_ip private_ranges
    }
    redir @admin /

    reverse_proxy vaultwarden:80 {
      header_up X-Real-IP {remote_host}
    }
  '';

  programs.quadlets.quadlets."vaultwarden.container" = lib.attrsets.recursiveUpdate {
    Container = {
      Image = "docker.io/vaultwarden/server:latest";
      Volume = utils.mapVolume "vaultwarden" [
        ":/data"
      ];
    }
    // utils.appendEnv "vaultwarden";
  } (utils.containerDefaults "vaultwarden" "systemd-caddy");
}
