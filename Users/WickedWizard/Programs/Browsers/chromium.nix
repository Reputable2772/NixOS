{ osConfig, pkgs, ... }: {
  home.packages = with pkgs; [ ungoogled-chromium ];

  home.sessionVariables = {
    CHROME_USER_DATA_DIR = "${osConfig.programs.config_dir.browser_dir}/Chromium";
  };
}
