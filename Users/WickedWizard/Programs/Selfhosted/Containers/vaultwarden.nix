{
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

  programs.quadlets.quadlets."vaultwarden.container" = {
    Container = {
      ContainerName = "vaultwarden";
      Network = "systemd-caddy";
      Image = "docker.io/vaultwarden/server:latest";
      Volume = [
        ":/data"
      ];
    };
  };
}
