{ config, pkgs, ... }: {
  home.packages = with pkgs; [ rclone ];
}
