{
  osConfig,
  config,
  config',
  lib,
  ...
}:
let
  utils = import ./utils.nix { inherit config config' lib; };
in
{
  containers.caddy.services.ente = "ente_museum:8080";

  # Museum is the main Ente server.
  programs.quadlets.quadlets."ente_museum.container" =
    lib.attrsets.recursiveUpdate (utils.containerDefaults "ente_museum" "systemd-caddy")
      {
        Container = {
          Image = "ghcr.io/ente-io/server";
          Volume = utils.mapVolume "ente_museum" [
            "logs:/var/logs"
            # TODO: Write these two YAML file declaratively.
            "museum.yaml:/museum.yaml:ro"
            "credentials.yaml:/credentials.yaml"
            "data:/data:ro"
          ];
        } // utils.appendEnv "ente_museum";
        Service.ExecStartPre = [
          "${lib.getExe osConfig.virtualisation.podman.package} wait --condition healthy ente_postgres"
        ];
        Unit = {
          After = [ "ente_postgres.service" ];
          Requires = [ "ente_postgres.service" ];
        };
      };

  programs.quadlets.quadlets."ente_postgres.container" = lib.attrsets.recursiveUpdate {
    Container = {
      Network = "systemd-caddy";
      HealthCmd = lib.strings.concatStringsSep " " [
        "pg_isready"
        "-q"
        "-d"
        ''''${ENTE_DB_NAME}''
        "-U"
        ''''${ENTE_DB_USER}''
      ];
      HealthStartPeriod = "40s";
      HealthStartupInterval = "1s";
      Notify = "healthy";
      Image = "postgres:15";
      # We use the volume here, since the postgresql user does
      # not run as root, causing permission issues when trying to backup
      # the directory. Using volumes and `podman volume export` can fix this.
      Volume = [ "ente_postgres.volume:/var/lib/postgresql/data" ];
    } // utils.appendEnv "ente_postgres";
  } (utils.containerDefaults "ente_postgres" "systemd-caddy");

  programs.quadlets.quadlets."ente_postgres.volume" = lib.attrsets.recursiveUpdate utils.defaults {
    Unit.Description = "Ente Postgres Volume";
    Volume.VolumeName = "ente_postgres";
    Service = {
      Type = "oneshot";
      Restart = "on-failure";
    };
  };

  # Containers below are only required to run Ente Photos.

  # programs.quadlets.quadlets."ente_socat.container" =
  #   lib.attrsets.recursiveUpdate
  #     {
  #       Container = {
  #         Image = "docker.io/alpine/socat";
  #         Exec = "'TCP-LISTEN:3200,fork,reuseaddr' TCP:ente_minio:3200";
  #         Network = "container:ente_museum";
  #       } // utils.appendEnv "ente_socat";

  #       Unit = {
  #         Requires = [ "ente_museum.service" ];
  #         After = [ "ente_museum.service" ];
  #       };
  #     }
  #     (
  #       (lib.attrsets.removeAttrs (utils.containerDefaults "ente_socat" "systemd-caddy") [ "Container" ])
  #       // {
  #         Container = {
  #           ContainerName = "ente_socat";
  #           PodmanArgs = "--user 0:0";
  #         };
  #       }
  #     );

  # programs.quadlets.quadlets."ente_minio.container" = lib.attrsets.recursiveUpdate {
  #   Container = {
  #     Image = "docker.io/minio/minio";
  #     Network = "systemd-caddy";
  #     Exec = "server /data --address \":3200\" --console-address \":3201\"";
  #     Volume = utils.mapVolume "ente_minio" [
  #       "data:/data"
  #     ];
  #   } // utils.appendEnv "ente_minio";
  # } (utils.containerDefaults "ente_minio" "systemd-caddy");

  # programs.quadlets.quadlets."ente_minio-provision.container" = lib.attrsets.recursiveUpdate {
  #   Container = {
  #     Entrypoint = "/provision.sh";
  #     Image = "docker.io/minio/mc";
  #     Network = "systemd-caddy";
  #     Volume = utils.mapVolume "ente_minio-provision" [
  #       # TODO: Get this file declaratively from Github.
  #       "provision.sh:/provision.sh:ro"
  #       "data:/data"
  #     ];
  #   } // utils.appendEnv "ente_minio-provision";

  #   Unit = {
  #     Requires = [ "ente_minio.service" ];
  #     After = [ "ente_minio.service" ];
  #   };
  # } (utils.containerDefaults "ente_minio-provision" "systemd-caddy");
}
