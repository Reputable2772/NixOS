{ config, ... }: {
  networking.hostName = "oracle-server";
  networking.firewall = config.hm-config.firewall;

  /**
    Look at the crowdsec container for more info.
  */
  services.crowdsec-firewall-bouncer = {
    enable = true;
    settings.api_url = "http://127.0.0.1:8008";
    secrets.apiKeyPath = config.age.secrets.oracle-crowdsec-firewall-bouncer.path;
  };

  boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;
}
