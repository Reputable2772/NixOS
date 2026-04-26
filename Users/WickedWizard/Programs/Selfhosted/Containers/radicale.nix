{
  config,
  pkgs,
  lib,
  ...
}:
let
  userFilePath = "/config/users";
  radicaleConfig = lib.generators.toINI { } {
    auth = {
      type = "htpasswd";
      htpasswd_filename = userFilePath;
      htpasswd_encryption = "autodetect";
    };
    storage.filesystem_folder = "/data";

    server.hosts = "0.0.0.0:5232, [::]:5232";
  };
in
{
  containers.caddy.services.radicale = "radicale:5232";

  # Mounted directly as a file, not an environment variable.
  age.secrets.radicale.file = ../../../../../Config/radicale.age;

  programs.quadlets.quadlets."radicale.container" = {
    Container = {
      Image = "docker.io/tomsquest/docker-radicale";
      ContainerName = "radicale";
      Network = "systemd-caddy.network";
      AddCapability = [
        "CHOWN"
        "SETUID"
        "SETGID"
        "KILL"
      ];
      DropCapability = "ALL";
      NoNewPrivileges = true;
      RunInit = true;
      Label = [ "wud.watch.digest=true" ];

      # Radicale tries to drop privileges inside the container,
      # meaning that it cannot read the mounted /config/users file.
      # Forcing it to run as root inside the container means that it has
      # the same permissions as the outer user, so it can read
      # the mounted agenix file.
      Environment = [
        "UID=0"
        "GID=0"
      ];

      Volume = [
        "data:/data"
        "radicale/users:/etc/radicale/users"
        "${pkgs.writeText "radicale-config" radicaleConfig}:/config/config:ro:noMap"
        "${config.age.secrets.radicale.path}:${userFilePath}:noMap"
      ];

      HealthCmd = "curl --fail http://127.0.0.1:5232 || exit 1";
      HealthInterval = "30s";
      HealthRetries = 3;
    };
  };
}
