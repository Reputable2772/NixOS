{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) types;
  inherit (lib.options) mkOption;
  inherit (lib.strings) concatMapAttrsStringSep concatStringsSep optionalString;

  cfg = config.containers.caddy;
  caddyFile = pkgs.writeTextFile {
    name = "Caddyfile";
    text = ''
      {
        # Master Access File
        # Captures ONLY HTTP requests across all domains.
        log master_access {
          include http.log.access
          output file /data/logs/master_access.json.log {
            roll_size 50MiB
            roll_keep 30
          }
          format json
        }

        # Master Error Files (Stderr & File)
        # Captures system and TLS errors and writes to both outputs.
        log system_errors_console {
          level ERROR
          output stderr
          format transform `🚨 [{ts}] [{logger}] {msg} {error}` {
            time_format "15:04:05"
          }
        }

        log system_errors_file {
          level ERROR
          output file /data/logs/master_errors.log {
            roll_size 10MiB
            roll_keep 10
          }
          format transform `🚨 [{ts}] [{logger}] {msg} {error}` {
            time_format "15:04:05"
          }
        }

        # Needed for crowdsec logs.
        log {
          output file /logs/caddy/access.log {
            roll_size 30MiB
            roll_keep 5
          }
        }

        crowdsec {
          api_url http://crowdsec:8080
          api_key {env.CROWDSEC_API_KEY}
          ticker_interval 15s
        }

        admin unix//run/admin.sock
        auto_https disable_redirects
      }

      http:// {
        bind fd/4 {
          protocols h1
        }
        redir https://{host}{uri} 308

        # HTTP Redirect Log
        log {
          output file /data/logs/http_redirects.combined.log {
            roll_size 10MiB
            roll_keep 10
          }
          format transform "{combined_log}"
        }
      }

      (wildcard_dns) {
        tls {
          dns desec {
            token {env.DESEC_TOKEN}
          }

          # Since my ISP sucks.
          propagation_timeout 300s
          propagation_delay 120s
          resolvers 1.1.1.1
        }

        bind fd/5 {
          protocols h1 h2
        }
        bind fdgram/3 {
          protocols h3
        }
      }

      {env.FQDN} {
        import wildcard_dns
        log access
        log
        route {
          crowdsec
          respond "{http.request.remote.host}"
        }
      }

      ${optionalString (cfg.extraConfig != [ ]) (concatStringsSep "\n" cfg.extraConfig)}
      *.{env.FQDN} {
        import wildcard_dns
        log access
        log

        ${optionalString (cfg.services != { }) (
          concatMapAttrsStringSep "\n" (n: v: ''
            @${n} host ${n}.{env.FQDN}
            handle @${n} {
              route {
                crowdsec
                reverse_proxy ${v}
              }
            }
          '') cfg.services
        )}

        ${optionalString (cfg.servicesExtraConfig != { }) (
          # Handling is done by the extraConfig, like in vaultwarden.nix
          concatMapAttrsStringSep "\n" (n: v: ''
            @${n} host ${n}.{env.FQDN}
              handle @${n} {
                route {
                  crowdsec
                  ${v}
                }
              }
          '') cfg.servicesExtraConfig
        )}
      }
    '';
    checkPhase = ''
      ${lib.getExe pkgs.caddy} fmt $out --overwrite
    '';
  };
in
{
  options.containers.caddy = {
    services = mkOption {
      default = { };
      description = "List of services for caddy to reverse proxy to.";
      type = types.attrs;
    };
    servicesExtraConfig = mkOption {
      default = { };
      description = "Extraconfig to add to caddy reverse proxy.";
      type = types.attrs;
    };
    extraConfig = mkOption {
      default = [ ];
      description = "Extraconfig added directly to caddy settings.";
      type = types.listOf types.str;
    };
  };

  config = {
    system-config.firewall = rec {
      allowedUDPPorts = [
        80
        443
      ];
      allowedTCPPorts = allowedUDPPorts;
    };

    containers.caddy.servicesExtraConfig.test = ''
      respond "{{.RemoteIP}}"
    '';

    programs.quadlets.extraServices = [
      "caddy.socket"
    ];

    systemd.user.sockets.caddy = {
      Socket = {
        BindIPv6Only = "both";
        # fdgram/3
        ListenDatagram = [ "[::]:443" ];
        ListenStream = [
          # fd/4
          "[::]:80"
          # fd/5
          "[::]:443"
        ];
      };
      Install.WantedBy = [ "sockets.target" ];
    };

    containers.crowdsec = {
      bouncers."caddy.yaml" = {
        filename = "/logs/caddy/access.log";
        labels.type = "caddy";
      };
      collections = [
        "crowdsecurity/caddy"
        "crowdsecurity/http-cve"
        "crowdsecurity/whitelist-good-actors"
      ];
    };

    programs.quadlets.quadlets."caddy.container" = {
      Container = {
        ContainerName = "caddy";
        Network = "systemd-caddy.network";
        Image = "caddy-image.build";
        Volume = [
          "${caddyFile}:/etc/caddy/Caddyfile:noMap"
          "config:/config"
          "data:/data"
          "crowdsec-logs.volume:/logs"
        ];
        # Can't get WUD to watch the Docker Registry
        # for caddy itself. Therefore, we'll turn it off for onw.
        Label = [ "wud.watch=false" ];
      };
    };

    programs.quadlets.quadlets."caddy-image.build".Build = {
      ImageTag = "localhost/caddy";
      File = pkgs.writeText "caddy-containerfile" ''
        FROM docker.io/caddy:builder AS builder

        RUN xcaddy build \
          --with github.com/caddy-dns/desec \
          --with github.com/caddyserver/transform-encoder \
          --with github.com/hslatman/caddy-crowdsec-bouncer/http@main \
          --with github.com/hslatman/caddy-crowdsec-bouncer/appsec@main \
          --with github.com/hslatman/caddy-crowdsec-bouncer/layer4@main

        FROM docker.io/caddy:latest

        COPY --from=builder /usr/bin/caddy /usr/bin/caddy
      '';
    };
  };
}
