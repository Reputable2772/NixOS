{ config, ... }: {
  containers.caddy.servicesExtraConfig.vaultwarden = ''
    @admin {
      path /admin*
      not remote_ip private_ranges
    }
    redir @admin /

    reverse_proxy vaultwarden:80 {
      header_up X-Real-IP {remote_host}
    }
  '';

  secretspec.config = {
    profiles.wickedwizard = {
      # https://github.com/dani-garcia/vaultwarden/wiki/Enabling-Mobile-Client-push-notification
      PUSH_INSTALLATION_ID.description = "Push installation id for Vaultwarden";
      PUSH_INSTALLATION_KEY.description = "Push installation key for Vaultwarden";
    };
    scopes.push_installation.secrets = [
      "PUSH_INSTALLATION_ID"
      "PUSH_INSTALLATION_KEY"
    ];
  };

  programs.quadlets.quadlets."vaultwarden.container" = {
    Container = {
      ContainerName = "vaultwarden";
      EnvironmentFile = config.secretspec.secrets.scopes.push_installation.path;
      Network = "systemd-caddy.network";
      Image = "ghcr.io/dani-garcia/vaultwarden:latest";
      Volume = [
        ":/data"
      ];
    };
  };
}
