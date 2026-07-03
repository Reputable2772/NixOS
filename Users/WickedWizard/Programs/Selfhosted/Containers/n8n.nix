{
  config',
  pkgs,
  lib,
  ...
}:
{
  containers.caddy.services.n8n = "n8n:5678";

  # n8n runs in external mode.
  programs.quadlets.quadlets."n8n.container" = {
    Container = {
      ContainerName = "n8n";
      Image = "docker.io/n8nio/n8n:latest";
      Network = [
        "systemd-caddy.network"
        "n8n.network"
        "ollama.network"
      ];
      Environment = [
        "N8N_RUNNERS_ENABLED=true"
        "N8N_RUNNERS_MODE=external"
        "N8N_NATIVE_PYTHON_RUNNER=true"
        "N8N_RUNNERS_BROKER_LISTEN_ADDRESS=0.0.0.0"
      ];
      Volume = [
        "n8n.volume:/root/.n8n"
      ]
      ++ lib.lists.map (v: "${v}:noMap") config'.containers.n8n.custom.volumeMounts;
    };
  };

  programs.quadlets.quadlets."n8n-runner.container" = {
    Container = {
      ContainerName = "n8n-runner";
      Image = "docker.io/n8nio/runners:latest";
      Network = "n8n.network";
      Environment = [
        "N8N_RUNNERS_TASK_BROKER_URI=http://n8n:5679"
      ];
      Volume = [
        # Taken from https://github.com/n8n-io/n8n/blob/5f92be5fabfcbd119d364cf4566f679a48acb227/docker/images/runners/n8n-task-runners.json
        # Don't remove and assume default config. This config is necessary for multiple runners,
        # since each runner requires its own health-check-server-port and that is not configured
        # by default.
        "${
          pkgs.writeText "n8n-task-runners" (
            builtins.toJSON {
              task-runners = [
                {
                  runner-type = "javascript";
                  workdir = "/home/runner";
                  command = "/usr/local/bin/node";
                  args = [
                    "--disallow-code-generation-from-strings"
                    "--disable-proto=delete"
                    "/opt/runners/task-runner-javascript/dist/start.js"
                  ];
                  health-check-server-port = "5681";
                  allowed-env = [
                    "PATH"
                    "GENERIC_TIMEZONE"
                    "NODE_OPTIONS"
                    "NODE_PATH"
                    "N8N_RUNNERS_AUTO_SHUTDOWN_TIMEOUT"
                    "N8N_RUNNERS_TASK_TIMEOUT"
                    "N8N_RUNNERS_MAX_CONCURRENCY"
                    "N8N_SENTRY_DSN"
                    "N8N_VERSION"
                    "ENVIRONMENT"
                    "DEPLOYMENT_NAME"
                    "HOME"
                  ];
                  env-overrides = {
                    NODE_FUNCTION_ALLOW_BUILTIN = "crypto,fs";
                    # NODE_FUNCTION_ALLOW_EXTERNAL = "moment";
                    N8N_RUNNERS_HEALTH_CHECK_SERVER_HOST = "0.0.0.0";
                  };
                }
                {
                  runner-type = "python";
                  workdir = "/home/runner";
                  command = "/opt/runners/task-runner-python/.venv/bin/python";
                  args = [
                    "-I"
                    "-B"
                    "-X"
                    "disable_remote_debug"
                    "-m"
                    "src.main"
                  ];
                  health-check-server-port = "5682";
                  allowed-env = [
                    "PATH"
                    "N8N_RUNNERS_LAUNCHER_LOG_LEVEL"
                    "N8N_RUNNERS_AUTO_SHUTDOWN_TIMEOUT"
                    "N8N_RUNNERS_TASK_TIMEOUT"
                    "N8N_RUNNERS_MAX_CONCURRENCY"
                    "N8N_SENTRY_DSN"
                    "N8N_VERSION"
                    "ENVIRONMENT"
                    "DEPLOYMENT_NAME"
                  ];
                  env-overrides = {
                    N8N_RUNNERS_STDLIB_ALLOW = "json";
                    # N8N_RUNNERS_EXTERNAL_ALLOW = "";
                  };
                }
              ];
            }
          )
        }:/etc/n8n-task-runners.json:noMap"
      ];
    };
  };

  programs.quadlets.quadlets."n8n.volume".Volume.VolumeName = "n8n";
  programs.quadlets.quadlets."n8n.network".Network.NetworkName = "n8n";
}
