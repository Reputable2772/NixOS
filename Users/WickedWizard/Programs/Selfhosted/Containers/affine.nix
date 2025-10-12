{
  osConfig,
  config,
  config',
  lib,
  lib',
  ...
}:
let
  utils = import ./utils.nix { inherit config config' lib; };
in
{
  containers.caddy.services.affine = "affine_server:3010";

  programs.quadlets.quadlets."affine_server.container" =
    lib.attrsets.recursiveUpdate (utils.containerDefaults "affine_server" "systemd-caddy")
      {
        Container = lib'.deepMerge {
          Image = "ghcr.io/toeverything/affine:stable";
          Volume = utils.mapVolume "affine_server" [
            "storage:/root/.affine/storage"
            "config:/root/.affine/config"
          ];
          Environment = [
            "REDIS_SERVER_HOST=affine_redis"
            "AFFINE_INDEXER_ENABLED=false"
            # Do not nest environment variables, as nested variable expansion is not really possible atm.
            # "DATABASE_URL=postgresql://$$\{DB_USERNAME}:$$\{DB_PASSWORD}@affine_postgres:5432/$$\{DB_DATABASE}"
          ];
        } (utils.appendEnv "affine_server");
        Service.ExecStartPre = [
          # affine_migration exits on success, so we cannot wait it out.
          "${lib.getExe osConfig.virtualisation.podman.package} wait --condition healthy affine_redis"
          "${lib.getExe osConfig.virtualisation.podman.package} wait --condition healthy affine_postgres"
        ];
        Unit = {
          After = [
            "affine_postgres.service"
            "affine_redis.service"
            "affine_migration.service"
          ];
          Requires = [
            "affine_postgres.service"
            "affine_redis.service"
            "affine_migration.service"
          ];
        };
      };

  programs.quadlets.quadlets."affine_migration.container" =
    lib.attrsets.recursiveUpdate (utils.containerDefaults "affine_migration" "systemd-caddy")
      {
        Container = lib'.deepMerge {
          Network = "systemd-caddy";
          Image = "ghcr.io/toeverything/affine:stable";
          Volume = config.programs.quadlets.quadlets."affine_server.container".Container.Volume;
          Environment = config.programs.quadlets.quadlets."affine_server.container".Container.Environment;
          Exec = "node ./scripts/self-host-predeploy.js";
        } (utils.appendEnv "affine_migration");
        Service = {
          ExecStartPre = [
            "${lib.getExe osConfig.virtualisation.podman.package} wait --condition healthy affine_redis"
            "${lib.getExe osConfig.virtualisation.podman.package} wait --condition healthy affine_postgres"
          ];
          Restart = "on-failure";
        };
        Unit = {
          After = [
            "affine_postgres.service"
            "affine_redis.service"
          ];
          Requires = [
            "affine_postgres.service"
            "affine_redis.service"
          ];
        };
      };

  programs.quadlets.quadlets."affine_redis.container" = lib.attrsets.recursiveUpdate {
    Container = {
      Network = "systemd-caddy";
      Image = "redis";
      HealthCmd = "redis-cli --raw incr ping";
      HealthInterval = "10s";
      HealthTimeout = "5s";
      HealthRetries = 5;
      Notify = "healthy";
    }
    // utils.appendEnv "affine_redis";
  } (utils.containerDefaults "affine_redis" "systemd-caddy");

  programs.quadlets.quadlets."affine_postgres.container" = lib.attrsets.recursiveUpdate {
    Container = lib'.deepMerge {
      Network = "systemd-caddy";
      Environment = [
        "POSTGRES_INITDB_ARGS='--data-checksums'"
      ];
      # $$ is explained in ente.nix
      HealthCmd = "pg_isready -d $$\{POSTGRES_DB} -U $$\{POSTGRES_USER}";
      HealthStartupInterval = "10s";
      HealthRetries = 5;
      HealthTimeout = "5s";
      Notify = "healthy";
      Image = "pgvector/pgvector:pg16";
      Volume = [ "affine_postgres.volume:/var/lib/postgresql/data" ];
    } (utils.appendEnv "affine_postgres");
  } (utils.containerDefaults "affine_postgres" "systemd-caddy");

  programs.quadlets.quadlets."affine_postgres.volume" = lib.attrsets.recursiveUpdate utils.defaults {
    Unit.Description = "Affine Postgres Volume";
    Volume.VolumeName = "affine_postgres";
    Service = {
      Type = "oneshot";
      Restart = "on-failure";
    };
  };
}
