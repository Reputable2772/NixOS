{ config, config', inputs, lib, ... }: {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  boot.loader.systemd-boot.enable = lib.mkForce (!config.boot.lanzaboote.enable);
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "${config'.flake.dir.config}/secureboot";
  };
}
