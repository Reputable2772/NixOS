## Only configure devices and folders here. Configure rest through web interface.

{ config, ... }:
let
  documents = "${config.users.users.wickedwizard.home}/Documents";
  conf = path: {
    inherit path;
    devices = [ "default" ];
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
    dataDir = "${documents}/Config/Syncthing/data";
    configDir = "${documents}/Config/Syncthing";
    settings = {
      devices = rec {
        Redmi = { id = "FVKBTJS-3KMPR7D-2CXVBPR-F5HUD5E-7E2KJAT-ZABMG6E-4RK3CK6-H5OOMQP"; };
        default = Redmi;
      };
      folders = {
        "Backups" = conf "${documents}/Android/Backups";
        "Tasker" = conf "${documents}/Android/Tasker";
        "Books" = conf "${documents}/Books";
        "Important Files" = conf "${documents}/Important-Files";
        "Joplin" = conf "${documents}/Joplin";
        "Pictures" = conf "${documents}/Photos/Phone";
        "Study Materials" = conf "${documents}/Study Materials";
      };
    };
  };
}
