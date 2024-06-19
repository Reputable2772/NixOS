{ config, config', lib, pkgs, ... }: {
  programs.quadlets.quadlets =
    let
      dir = if config'.containers.caddy ? dir && config'.containers.caddy.dir != null then config'.containers.caddy.dir else "${config'.dir.containers}/Caddy";
      caddyFile = pkgs.writeText "Caddyfile" ''
        (default) {
          tls {
            dns duckdns {env.DUCKDNS_TOKEN}

            # Since my ISP sucks.
            propagation_timeout -1
          }

          header {
            Strict-Transport-Security "max-age=31536000;"
            X-XSS-Protection "1; mode=block"
            X-Frame-Options "SAMEORIGIN"
            X-Robots-Tag "none"
            -Server
          }
          encode gzip
        }

        {
          # acme_ca https://acme-staging-v02.api.letsencrypt.org/directory
          # debug
          log {
            level info
            output file {env.LOG_FILE} {
              roll_size 10MB
              roll_keep 10
            }
            output stdout
            format console {
              time_format iso8601
            }
          }

          servers {
            metrics
          }
          admin :2019
        }

        {env.DOMAIN} {env.EXTERNAL_DOMAIN} {
          import default

          reverse_proxy baikal:80
        }

        *.{env.DOMAIN} *.{env.EXTERNAL_DOMAIN} {
          import default

          @vaultwarden host vaultwarden.{env.DOMAIN} vaultwarden.{env.EXTERNAL_DOMAIN}
          handle @vaultwarden {
            @admin {
              path /admin*
              not remote_ip private_ranges
            }
            redir @admin /

            reverse_proxy vaultwarden:80 {
              header_up X-Real-IP {remote_host}
            }
          }

          @baikal host baikal.{env.DOMAIN} baikal.{env.EXTERNAL_DOMAIN}
          handle @baikal {
            reverse_proxy baikal:80
          }

          @qbittorrent host qbittorrent.{env.DOMAIN} qbittorrent.{env.EXTERNAL_DOMAIN}
          handle @qbittorrent {
            reverse_proxy qbittorrent:8516
          }

          @lidarr host lidarr.{env.DOMAIN} lidarr.{env.EXTERNAL_DOMAIN}
          handle @lidarr {
            # Lidarr's traffic is proxied through Gluetun.
            reverse_proxy gluetun:8686
          }
      '';
    in
    [
      {
        name = "caddy.container";
        content = ''
          [Container]
          ContainerName=caddy
          ${lib.optionalString (config'.containers.caddy ? env && config'.containers.caddy.env != null) "Environment=${lib.strings.concatStringsSep " " config'.containers.caddy.env}"}
          ${lib.optionalString (config'.containers.caddy ? envFiles && config'.containers.caddy.envFiles != null) (lib.strings.concatStringsSep "\n" (lib.lists.map (n: "EnvironmentFile=${config.age.secrets.${n}.path}") config'.containers.caddy.envFiles))}
          Image=caddy
          Network=systemd-caddy
          PodmanArgs=--network-alias caddy
          PublishPort=80:80
          PublishPort=443:443
          PublishPort=2019:2019
          Volume=${caddyFile}:/etc/caddy/Caddyfile
          Volume=${dir}/config:/config
          Volume=${dir}/data:/data

          [Unit]
          Wants=network-online.target
          After=network-online.target

          [Service]
          Restart=always
          TimeoutStartSec=300

          [Install]
          WantedBy=default.target
        '';
      }
    ];
}
