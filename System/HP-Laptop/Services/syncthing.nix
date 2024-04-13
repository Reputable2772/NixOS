## Only configure devices and folders here. Configure rest through web interface.

{ config, ... }:
let
  documents = config.programs.config_dir.config_dir;
  conf = _path: {
    path = "${documents}/${_path}";
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
        "Backups" = conf "Android/Backups";
        "Tasker" = conf "Android/Tasker";
        "Books" = conf "Books";
        "Important Files" = conf "Important-Files";
        "Joplin" = conf "Joplin";
        "Study Materials" = conf "Study Materials";
      };
    };
  };
}
