{ config, ... }: {
  networking.hostName = "oracle-server";
  networking.firewall = config.hm-config.firewall;

  secretspec.config.profiles.oracle-server.CROWDSEC_FIREWALL_BOUNCER.description =
    "API Key for Crowdsec Firewall bouncer";

  /**
    Look at the crowdsec container for more info.
  */
  services.crowdsec-firewall-bouncer = {
    enable = true;
    settings.api_url = "http://127.0.0.1:8008";
    secrets.apiKeyPath =
      config.secretspec.secrets.profiles.oracle-server.CROWDSEC_FIREWALL_BOUNCER.plainPath;
  };

  boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;
}
