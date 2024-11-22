{
  osConfig,
  config,
  config',
  lib,
  pkgs,
  ...
}:
let
  utils = import ./utils.nix { inherit config config' lib; };
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
      log {
        output file {env.LOG_FILE} {
          roll_size 10MB
          roll_keep 10
        }
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

      @syncthing host syncthing.{env.DOMAIN} syncthing.{env.EXTERNAL_DOMAIN}
      handle @syncthing {
        reverse_proxy syncthing:8384
      }
    }
  '';
  containerfile = pkgs.writeText "caddy-containerfile" ''
    FROM docker.io/caddy:2.8.4-builder AS builder

    RUN xcaddy build \
        --with github.com/caddy-dns/duckdns

    FROM docker.io/caddy:2.8.4

    COPY --from=builder /usr/bin/caddy /usr/bin/caddy
  '';
in
{
  # recursiveUpdate is not used on purpose.
  systemd.user.services.caddy-image = utils.defaults // {
    Service = {
      ExecStart = "${lib.getExe osConfig.virtualisation.podman.package} image build -t caddy -f ${containerfile}";
      Restart = "on-failure";
      Type = "oneshot";
    };
  };

  programs.quadlets.quadlets."caddy.container" =
    (lib.attrsets.recursiveUpdate {
      Container = {
        Image = "localhost/caddy";
        Network = "systemd-caddy";
        PublishPort = [
          "80:80"
          "443:443"
        ];
        Volume =
          [
            "${caddyFile}:/etc/caddy/Caddyfile"
          ]
          ++ utils.mapVolume "caddy" [
            "config:/config"
            "data:/data"
          ];
      } // utils.appendEnv "caddy";
    } (utils.containerDefaults "caddy" "systemd-caddy"))
    // {
      Unit = {
        After = [ "caddy-image.service" ];
        Requires = [ "caddy-image.service" ];
      };
    };
}
