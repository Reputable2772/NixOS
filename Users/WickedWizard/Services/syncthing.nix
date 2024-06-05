{ config', lib, ... }:
{
  services.syncthing = {
    enable = lib.mkIf
      (lib.attrsets.hasAttrByPath [ "config" "dir" "config" ] config')
      true;
    extraOptions = [
      "--config=${config'.config.dir.config}/Syncthing"
      "--data=${config'.config.dir.config}/Syncthing/data"
    ];
  };
}
