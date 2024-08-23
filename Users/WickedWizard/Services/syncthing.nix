{ config', ... }:
{
  services.syncthing = {
    enable = false;
    extraOptions = [
      "--config=${config'.dir.config}/Syncthing"
      # "--data=${config'.dir.config}/Syncthing/data"
    ];
  };
}
