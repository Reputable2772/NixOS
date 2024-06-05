{ config', lib, ... }:
{
  services.syncthing = {
    enable = lib.mkIf
      (config'.config.dir ? config)
      true;
    extraOptions = [
      "--config=${config'.config.dir.config}/Syncthing"
      "--data=${config'.config.dir.config}/Syncthing/data"
    ];
  };
}
