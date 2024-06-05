{ config', pkgs, lib, ... }: {
  home.packages = with pkgs; [ ungoogled-chromium ];

  home.sessionVariables.CHROME_USER_DATA_DIR = lib.mkIf
    (config'.config.dir ? browsers)
    "${config'.config.dir.browsers}/Chromium";
}
