{ config', config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ ungoogled-chromium ];

  home.sessionVariables.CHROME_USER_DATA_DIR = lib.mkIf
    (lib.attrsets.hasAttrByPath [ "config" "dir" "browsers" ] config'.users.${config.home.username})
    "${config'.users.${config.home.username}.config.dir.browsers}/Chromium";
}
