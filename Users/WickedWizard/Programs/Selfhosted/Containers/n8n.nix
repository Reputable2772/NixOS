{ config', lib, ... }:
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
      Environment = [ "N8N_RUNNERS_BROKER_LISTEN_ADDRESS=0.0.0.0" ];
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
    };
  };

  programs.quadlets.quadlets."n8n.volume".Volume.VolumeName = "n8n";
  programs.quadlets.quadlets."n8n.network".Network.NetworkName = "n8n";
}
