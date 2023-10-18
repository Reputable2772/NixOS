{ config, pkgs, ... }: {
  home.packages = with pkgs; [ ungoogled-chromium ];

  home.sessionVariables = {
    CHROME_USER_DATA_DIR = "$HOME/Documents/Browsers/Chromium";
  };
}
