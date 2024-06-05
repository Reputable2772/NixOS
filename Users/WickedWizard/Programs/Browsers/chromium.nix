{ config', pkgs, lib, ... }: {
  home.packages = with pkgs; [ ungoogled-chromium ];

  home.sessionVariables.CHROME_USER_DATA_DIR = lib.mkIf
    (lib.attrsets.hasAttrByPath [ "config" "dir" "browsers" ] config')
    "${config'.config.dir.browsers}/Chromium";
}
