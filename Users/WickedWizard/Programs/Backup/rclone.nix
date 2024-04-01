{ pkgs, ... }: {
  home.packages = with pkgs; [ rclone ];

  home.sessionVariables = {
    RCLONE_CONFIG = "$HOME/Documents/Config/rclone.conf";
  };
}
