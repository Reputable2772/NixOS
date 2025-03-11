{
  osConfig,
  config,
  config',
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) types;
  inherit (lib.options) mkOption;
  inherit (lib.strings) concatMapAttrsStringSep concatStringsSep optionalString;

  cfg = config.containers.caddy;

  utils = import ./utils.nix { inherit config config' lib; };
  caddyFile = pkgs.writeTextFile {
    name = "Caddyfile";
    text = ''
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

        ${optionalString (cfg.services != { }) (
          concatMapAttrsStringSep "\n" (n: v: ''
            @${n} host ${n}.{env.DOMAIN} ${n}.{env.EXTERNAL_DOMAIN}
            handle @${n} {
              reverse_proxy ${v}
            }
          '') cfg.services
        )}

        ${optionalString (cfg.extraConfig != [ ]) (concatStringsSep "\n" cfg.extraConfig)}
      }
    '';
    checkPhase = ''
      ${lib.getExe pkgs.caddy} fmt $out --overwrite
    '';
  };
  containerfile = pkgs.writeText "caddy-containerfile" ''
    FROM docker.io/caddy:2.8.4-builder AS builder

    RUN xcaddy build \
        --with github.com/caddy-dns/duckdns

    FROM docker.io/caddy:2.8.4

    COPY --from=builder /usr/bin/caddy /usr/bin/caddy
  '';
in
{
  options.containers.caddy = {
    services = mkOption {
      default = { };
      description = "List of services for caddy to reverse proxy to.";
      type = types.attrs;
    };
    extraConfig = mkOption {
      default = [ ];
      description = "Extraconfig to add to caddy reverse proxy.";
      type = types.listOf types.str;
    };
  };

  config = {
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
  };
}
