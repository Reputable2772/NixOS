{ config', lib, ... }: {
  programs.quadlets.enable =
    config'.config.dir ? containers &&
    lib.strings.typeOf config'.config.dir.containers == "string";

  imports = [
    ./baikal.nix
    ./caddy.nix
    ./caddy-network.nix
    ./qbittorrent.nix
    ./vaultwarden.nix
  ];
}
