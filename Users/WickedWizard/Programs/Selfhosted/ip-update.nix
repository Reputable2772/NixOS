{
  config,
  pkgs,
  ...
}:
{
  systemd.user.services.ip-update = {
    Unit = {
      Description = "IP Update service.";
    };

    Service = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "ip-update-service" ''
        set -euo pipefail
        source ${config.age.secrets.wickedwizard-domains.path}

        domain=$(echo $DOMAIN)
        subname=$(echo $SUBNAME)
        ip6=$(curl -L "https://ipv6.seeip.org/")
        ip_cache_file="/tmp/ddns_last_ip_$domain"

        if [ -f "$ip_cache_file" ]; then
            last_ip=$(cat "$ip_cache_file")
            if [ "$ip6" = "$last_ip" ]; then
                exit 0
            fi
        fi

        curl -X PUT "https://desec.io/api/v1/domains/$domain/rrsets/" \
          -H "Authorization: Token $DESEC_TOKEN" \
          -H "Content-Type: application/json" \
          -d "[{\"subname\": \"$subname\", \"type\": \"AAAA\", \"ttl\": 3600, \"records\": [\"$ip6\"]}, {\"subname\": \"*\", \"type\": \"AAAA\", \"ttl\": 3600, \"records\": [\"$ip6\"]}]"

        echo "$ip6" > "$ip_cache_file"
      '';
    };
  };

  systemd.user.timers.ip-update = {
    Unit = {
      Description = "IP Update timer for 5min.";
    };

    Timer = {
      OnBootSec = "1min";
      OnUnitActiveSec = "5min";
      AccuracySec = "1s";
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
