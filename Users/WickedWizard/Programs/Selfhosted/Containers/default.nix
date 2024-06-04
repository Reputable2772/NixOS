{ config, config', lib, ... }: {
  programs.quadlets.enable =
    config'.users.${config.home.username}.config.dir ? containers &&
    lib.strings.typeOf config'.users.${config.home.username}.config.dir.containers == "string";

  imports = [
    ./baikal.nix
    ./caddy.nix
    ./caddy-network.nix
    ./qbittorrent.nix
    ./vaultwarden.nix
  ];
}
