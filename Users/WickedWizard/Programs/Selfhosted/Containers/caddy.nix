{ config, config', lib, pkgs, ... }:
let
  utils = import ./utils.nix { inherit config config' lib; };
in
{
  programs.quadlets.quadlets."caddy.container" =
    let
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
    lib.attrsets.recursiveUpdate
      {
        Container = {
          Image = "caddy";
          Network = "systemd-caddy";
          PublishPort = [
            "80:80"
            "443:443"
          ];
          Volume = [
            "${caddyFile}:/etc/caddy/Caddyfile"
          ] ++ utils.mapVolume "caddy" [
            "config:/config"
            "data:/data"
          ];
        } // utils.appendEnv "caddy";
      }
      (utils.defaults "caddy");
}
