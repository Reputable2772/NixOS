{ config, pkgs, ... }:
{
  systemd.user.services.ip-update = {
    Unit = {
      Description = "IP Update service.";
    };

    Service = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "ip-update-service" ''
        source ${config.age.secrets.domains.path}

        ip=$(ip -4 addr show wlo1 | awk '/inet/ {print $2}' | awk -F/ '{print $1}')
        ip6=$(curl -L "https://ipv6.seeip.org/")
        secret=$(echo $DUCKDNS_TOKEN)
        domain=$(echo $DOMAIN)

        curl -X GET "https://www.duckdns.org/update"
          --data-urlencode "token=$secret" \
          --data-urlencode "domains=$DOMAIN" \
          --data-urlencode "ip=$ip" \
          --data-urlencode "verbose=true" \
          --data-urlencode "ipv6=$ip6"
      '';
    };
  };

  systemd.user.timers.ip-update = {
    Unit = {
      Description = "IP Update timer for 15mins.";
    };

    Timer = {
      OnCalendar = [ "*-*-* *:00/30:*" ];
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
