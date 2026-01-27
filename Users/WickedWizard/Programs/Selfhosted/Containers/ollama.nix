{
  config,
  config',
  lib,
  ...
}:
let
  utils = import ./utils.nix { inherit config config' lib; };
in
{
  containers.caddy.services.ollama = "ollama:11434";

  programs.quadlets.quadlets."ollama.container" = lib.attrsets.recursiveUpdate {
    Container = {
      Image = "docker.io/ollama/ollama:latest";
      Volume = utils.mapVolume "ollama" [
        "data:/root/.ollama"
      ];
      AddDevice = "/dev/dri";
      GroupAdd = "keep-groups";
    }
    // utils.appendEnv "ollama";
  } (utils.containerDefaults "ollama" "systemd-caddy");
}
