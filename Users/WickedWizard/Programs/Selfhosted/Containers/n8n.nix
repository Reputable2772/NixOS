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
        "${
          pkgs.writeText "n8n-task-runners" (
            builtins.toJSON {
              task-runners = [
                {
                  runner-type = "javascript";
                  env-overrides = {
                    NODE_FUNCTION_ALLOW_BUILTIN = "fs";
                    # NODE_FUNCTION_ALLOW_EXTERNAL = "moment,uuid";
                  };
                }
                {
                  runner-type = "python";
                  env-overrides = {
                    PYTHONPATH = "/opt/runners/task-runner-python";
                    N8N_RUNNERS_STDLIB_ALLOW = "json";
                    # N8N_RUNNERS_EXTERNAL_ALLOW = "numpy,pandas";
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
