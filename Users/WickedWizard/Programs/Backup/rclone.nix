{
  config,
  config',
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [ rclone ];

  age.secrets =
    lib.optionalAttrs (config'.secrets ? rcloneAgeFile && config'.secrets.rcloneAgeFile != null)
      {
        rclone = {
          file = ./. + "../../../../../Config/${config'.secrets.rcloneAgeFile}.age";
          path = "${config.xdg.configHome}/rclone/rclone.conf";
        };
      };
}
