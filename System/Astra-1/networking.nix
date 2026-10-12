{ config, ... }: {
  networking.hostName = "astra-1";
  networking.firewall = config.hm-config.firewall;

  secretspec.config.profiles.astra-1.CROWDSEC_FIREWALL_BOUNCER.description =
    "API Key for Crowdsec Firewall bouncer";

  /**
    Look at the crowdsec container for more info.
  */
  services.crowdsec-firewall-bouncer = {
    enable = true;
    settings.api_url = "http://127.0.0.1:8008";
    secrets.apiKeyPath = config.secretspec.secrets.profiles.astra-1.CROWDSEC_FIREWALL_BOUNCER.plainPath;
  };

  boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;
}
