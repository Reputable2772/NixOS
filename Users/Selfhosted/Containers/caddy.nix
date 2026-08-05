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
          dns desec {env.DESEC_TOKEN}

          # Since my ISP sucks.
          propagation_timeout -1
          resolvers 1.1.1.1
        }

        bind fd/5 {
          protocols h1 h2
        }
        bind fdgram/3 {
          protocols h3
        }
      }

      {env.DOMAIN} {
        import wildcard_dns
        log access
        respond "{http.request.remote.host}"
      }

      ${optionalString (cfg.extraConfig != [ ]) (concatStringsSep "\n" cfg.extraConfig)}
      *.{env.DOMAIN} {
        import wildcard_dns
        log access

        ${optionalString (cfg.services != { }) (
          concatMapAttrsStringSep "\n" (n: v: ''
            @${n} host ${n}.{env.DOMAIN}
            handle @${n} {
              reverse_proxy ${v}
            }
          '') cfg.services
        )}

        ${optionalString (cfg.servicesExtraConfig != { }) (
          # Handling is done by the extraConfig, like in vaultwarden.nix
          concatMapAttrsStringSep "\n" (n: v: ''
            @${n} host ${n}.{env.DOMAIN}
              handle @${n} {
                ${v}
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

    programs.quadlets.quadlets."caddy.container" = {
      Container = {
        ContainerName = "caddy";
        Network = "systemd-caddy.network";
        Image = "caddy-image.build";
        Volume = [
          "${caddyFile}:/etc/caddy/Caddyfile:noMap"
          "config:/config"
          "data:/data"
        ];
      };
    };

    programs.quadlets.quadlets."caddy-image.build".Build = {
      ImageTag = "localhost/caddy";
      File = pkgs.writeText "caddy-containerfile" ''
        FROM docker.io/caddy:builder AS builder

        RUN xcaddy build \
          --with github.com/caddyserver/transform-encoder

        FROM docker.io/caddy:latest

        COPY --from=builder /usr/bin/caddy /usr/bin/caddy
      '';
    };
  };
}
