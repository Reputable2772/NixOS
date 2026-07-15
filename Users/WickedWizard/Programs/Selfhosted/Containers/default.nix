{ config', lib, ... }: {
  programs.quadlets.enable =
    config'.dir ? containers && lib.strings.typeOf config'.dir.containers == "string";

  imports = [
    # ./baikal.nix
    ./caddy.nix
    ./caddy-network.nix
    ./ente.nix
    ./linkding.nix
    ./n8n.nix
    ./ollama.nix
    ./podman-socket-proxy.nix
    ./radicale.nix
    ./syncthing.nix
    ./vaultwarden.nix
    ./wud.nix
  ];
}
