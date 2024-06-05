{ config', lib, ... }:
{
  services.syncthing = {
    enable = lib.mkIf
      (config'.dir ? config)
      true;
    extraOptions = [
      "--config=${config'.dir.config}/Syncthing"
      "--data=${config'.dir.config}/Syncthing/data"
    ];
  };
}
