{ osConfig, pkgs, ... }: {
  home.packages = with pkgs; [ rclone ];

  home.sessionVariables = {
    RCLONE_CONFIG = "${osConfig.programs.config_dir.config_dir}/rclone.conf";
  };
}
