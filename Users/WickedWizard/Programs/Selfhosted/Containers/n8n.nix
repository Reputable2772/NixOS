{ config', lib, ... }:
{
  containers.caddy.services.n8n = "n8n:5678";

  programs.quadlets.quadlets."n8n.container" = {
    Container = {
      ContainerName = "n8n";
      Image = "docker.n8n.io/n8nio/n8n";
      Network = "systemd-caddy.network";
      Volume = [
        "n8n.volume:/root/.n8n"
      ]
      ++ lib.lists.map (v: "${v}:noMap") config'.containers.n8n.custom.volumeMounts;
    };
  };

  programs.quadlets.quadlets."n8n.volume".Volume.VolumeName = "n8n";
}
