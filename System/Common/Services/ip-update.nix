{ config, pkgs, ... }:
{
  secretspec.config = {
    profiles.${config.networking.hostName} = {
      BASE_DOMAIN.description = "The domain owned by the user.";
      SUBNAME.description = "The subname (without domain) used for this host.";
      HOST_DOMAIN = {
        composed = "\${SUBNAME}.\${BASE_DOMAIN}";
        description = "The subdomain used for this host.";
      };
      DESEC_TOKEN.description = "desec.io API Token";
    };
    scopes = rec {
      domain_ip_update.secrets = [
        "BASE_DOMAIN"
        "SUBNAME"
        "HOST_DOMAIN"
        "DESEC_TOKEN"
      ];
      common = domain_ip_update;
    };
  };

  systemd.services.ip-update = {
    description = "IP Update service.";

    serviceConfig = {
      Type = "oneshot";
      EnvironmentFile = config.secretspec.secrets.scopes.domain_ip_update.path;
      ExecStart = pkgs.writeShellScript "ip-update-service" ''
        set -euo pipefail

        domain=$(echo $BASE_DOMAIN)
        subname=$(echo $SUBNAME)
        token=$(echo $DESEC_TOKEN)
        ip6=$(
          ${pkgs.iproute2}/bin/ip -6 addr show scope global |
          ${pkgs.gawk}/bin/gawk '/inet6/ && $0 !~ / temporary / {
            split($2, a, "/")
            print a[1]
            exit
          }'
        )
        ip_cache_file="/tmp/ddns_last_ip_$subname.$domain"

        if [ -f "$ip_cache_file" ]; then
          last_ip=$(cat "$ip_cache_file")
          if [ "$ip6" = "$last_ip" ]; then
            exit 0
          fi
        fi

        ${pkgs.curl}/bin/curl -X PUT "https://desec.io/api/v1/domains/$domain/rrsets/" \
          -H "Authorization: Token $token" \
          -H "Content-Type: application/json" \
          -d "[{\"subname\": \"$subname\", \"type\": \"AAAA\", \"ttl\": 3600, \"records\": [\"$ip6\"]}, {\"subname\": \"*.$subname\", \"type\": \"AAAA\", \"ttl\": 3600, \"records\": [\"$ip6\"]}]"

        echo "$ip6" > "$ip_cache_file"
      '';
    };
  };

  systemd.timers.ip-update = {
    description = "IP Update timer for 5min.";

    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "5min";
      AccuracySec = "1s";
    };

    wantedBy = [ "timers.target" ];
  };
}
