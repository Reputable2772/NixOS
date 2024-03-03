## Only configure devices and folders here. Configure rest through web interface.

{ config, ... }:
let
  defaultConfig = {
    devices = [ "Redmi S2" ];
    versioning = {
      type = "trashcan";
      params.cleanoutDays = "1000";
    };
  };
in
{
  services.syncthing = {
    enable = true;
    user = "wickedwizard";
    systemService = true;
    dataDir = "${config.users.users.wickedwizard.home}/Documents/Config/Syncthing/data";
    configDir = "${config.users.users.wickedwizard.home}/Documents/Config/Syncthing";
    settings = {
      devices = {
        "Redmi S2" = { id = "FVKBTJS-3KMPR7D-2CXVBPR-F5HUD5E-7E2KJAT-ZABMG6E-4RK3CK6-H5OOMQP"; };
      };
      folders = {
        "Backups" = {
          path = "${config.users.users.wickedwizard.home}/Documents/Android/Backups";
        } // defaultConfig;
        "Books" = {
          path = "${config.users.users.wickedwizard.home}/Documents/Books";
        } // defaultConfig;
        "Captures" = {
          path = "${config.users.users.wickedwizard.home}/Documents/Android/Captures";
        } // defaultConfig;
        "Important Files" = {
          path = "${config.users.users.wickedwizard.home}/Documents/Important-Files";
        } // defaultConfig;
        "Joplin" = {
          path = "${config.users.users.wickedwizard.home}/Documents/Joplin";
        } // defaultConfig;
        "Magisk" = {
          path = "${config.users.users.wickedwizard.home}/Documents/Android/Magisk";
        } // defaultConfig;
        "Pictures" = {
          path = "${config.users.users.wickedwizard.home}/Documents/Photos/Phone";
        } // defaultConfig;
        "Study Materials" = {
          path = "${config.users.users.wickedwizard.home}/Documents/Study Materials";
        } // defaultConfig;
        "Tasker" = {
          path = "${config.users.users.wickedwizard.home}/Documents/Android/Tasker";
        } // defaultConfig;
      };
    };
  };
}
