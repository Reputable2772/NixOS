{
  config,
  config',
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  nix.settings = {
    substituters = [ "https://lanzaboote.cachix.org?priority=40" ];
    trusted-public-keys = [ "lanzaboote.cachix.org-1:Nt9//zGmqkg1k5iu+B3bkj3OmHKjSw9pvf3faffLLNk=" ];
  };

  boot.loader.systemd-boot.enable = lib.mkForce (!config.boot.lanzaboote.enable);
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "${config'.flake.dir.config}/secureboot/${config.networking.hostName}";
    settings = {
      editor = null;
    };
  };
}
