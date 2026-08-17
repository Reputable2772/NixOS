{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [ rclone ];

  secretspec.config.profiles.wickedwizard.RCLONE_CONFIG.description =
    "rclone.conf file, stored as is.";

  systemd.user.tmpfiles.rules = [
    "L+ ${config.xdg.configHome}/rclone/rclone.conf - - - - ${
      lib.replaceStrings [ "\${XDG_RUNTIME_DIR}" ] [ "%t" ]
        config.secretspec.secrets.profiles.wickedwizard.RCLONE_CONFIG.plainPath
    }"
  ];
}
