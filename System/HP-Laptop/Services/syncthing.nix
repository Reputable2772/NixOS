## Only configure devices and folders here. Configure rest through web interface.

{ config, pkgs, ... }: {
  services.syncthing = {
    enable = true;
    user = "wickedwizard";
    systemService = true;
    dataDir = "${config.users.users.wickedwizard.home}/Documents";
    configDir = "${config.users.users.wickedwizard.home}/Documents/Config/Syncthing";
    settings = {
      devices = {
        "Redmi S2" = { id = "FVKBTJS-3KMPR7D-2CXVBPR-F5HUD5E-7E2KJAT-ZABMG6E-4RK3CK6-H5OOMQP"; };
      };
      folders = {
        "Backups" = {
          path = "${config.users.users.wickedwizard.home}/Documents/Android/Backups";
          devices = [ "Redmi S2" ];
        };
        "Books" = {
          path = "${config.users.users.wickedwizard.home}/Documents/Books";
          devices = [ "Redmi S2" ];
        };
        "Important Files" = {
          path = "${config.users.users.wickedwizard.home}/Documents/Important-Files";
          devices = [ "Redmi S2" ];
        };
        "Joplin" = {
          path = "${config.users.users.wickedwizard.home}/Documents/Joplin";
          devices = [ "Redmi S2" ];
        };
        "Magisk" = {
          path = "${config.users.users.wickedwizard.home}/Documents/Android/Magisk";
          devices = [ "Redmi S2" ];
        };
        "Pictures" = {
          path = "${config.users.users.wickedwizard.home}/Documents/Pictures/Phone";
          devices = [ "Redmi S2" ];
        };
        "Study Materials" = {
          path = "${config.users.users.wickedwizard.home}/Documents/Study Materials";
          devices = [ "Redmi S2" ];
        };
        "Tasker" = {
          path = "${config.users.users.wickedwizard.home}/Documents/Android/Tasker";
          devices = [ "Redmi S2" ];
        };
        "Torrents" = {
          path = "${config.users.users.wickedwizard.home}/Documents/Torrents";
          devices = [ "Redmi S2" ];
        };
      };
    };
  };
}
