{ pkgs, ... }:
{
  home.packages = with pkgs; [ rclone ];

  # for the first time, directly copy rclone.conf
  # to its location. Symlinking it means that
  # refresh tokens and other secrets are lost.
  secretspec.config.profiles.wickedwizard = {
    # Not actually necessary, just stored here for ease of use.
    RCLONE_GDRIVE_CLIENT.description = "gdrive oauth client, rclone";
    RCLONE_CONFIG.description = "rclone.conf file, stored as is.";
  };
}
