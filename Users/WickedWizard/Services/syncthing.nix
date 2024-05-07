{ config', config, lib, ... }:
let
  userConfig = config'.users.${config.home.username};
in
{
  services.syncthing = {
    enable = lib.mkIf
      (lib.attrsets.hasAttrByPath [ "config" "dir" "config" ] config'.users.${config.home.username})
      true;
    extraOptions = [
      "--config=${userConfig.config.dir.config}/Syncthing"
      "--data=${userConfig.config.dir.config}/Syncthing/data"
    ];
  };
}
