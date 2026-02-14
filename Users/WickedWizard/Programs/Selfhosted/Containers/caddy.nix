{
  osConfig,
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
      (default) {
        tls {
          dns duckdns {env.DUCKDNS_TOKEN}

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
        log main
      }

      {
        # acme_ca https://acme-staging-v02.api.letsencrypt.org/directory
        log main {
          include http.log.access.main
          output file /var/log/caddy/access.log {
            roll_local_time
            roll_keep 90
            roll_keep_for 2160h
          }

          format transform `{request>host}: {request>remote_ip} - {request>user_id} [{ts}] "{request>method} {request>uri} {request>proto}" {status} {size} "{request>headers>Referer>[0]}" "{request>headers>User-Agent>[0]}"` {
            time_format "02/Jan/2006:15:04:05 -0700"
          }
        }

        log none {
          include http.log.access.none
          output discard
          format console
        }

        admin unix//run/admin.sock
        auto_https disable_redirects
      }

      http:// {
        bind fd/4 {
          protocols h1
        }
        redir https://{host}{uri} 308
        log main
      }

      {env.DOMAIN} {
        import default
        log main
        respond "{http.request.remote.host}"
      }

      ${optionalString (cfg.extraConfig != [ ]) (concatStringsSep "\n" cfg.extraConfig)}
      *.{env.DOMAIN} {
        import default
        log main

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
  containerfile = pkgs.writeText "caddy-containerfile" ''
    FROM docker.io/caddy:builder AS builder

    RUN xcaddy build \
        --with github.com/caddy-dns/duckdns \
        --with github.com/caddy-dns/cloudflare \
        --with github.com/caddyserver/transform-encoder

    FROM docker.io/caddy:latest

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

    systemd.user.services.caddy-image = {
      Service = {
        ExecStart = "${lib.getExe osConfig.virtualisation.podman.package} image build -t caddy -f ${containerfile}";
        Restart = "on-failure";
        Type = "oneshot";
      };
      Install.WantedBy = [ "default.target" ];
    };

    programs.quadlets.quadlets."caddy.container" = {
      Container = {
        ContainerName = "caddy";
        Network = "systemd-caddy";
        Image = "localhost/caddy";
        Volume = [
          "${caddyFile}:/etc/caddy/Caddyfile:noMap"
          "config:/config"
          "data:/data"
        ];
      };
      Unit = {
        After = [ "caddy-image.service" ];
        Requires = [ "caddy-image.service" ];
      };
    };
  };
}
