## Only configure devices and folders here. Configure rest through web interface.

{ config, ... }:
let
  inherit (config.programs.config_dir) base_dir config_dir;
  conf = _path: {
    path = "${base_dir}/${_path}";
    devices = [ "default" ];
    versioning = {
      type = "trashcan";
      params.cleanoutDays = "1000";
    };
  };
in
{
  services.syncthing = {
    enable = false;
    user = "wickedwizard";
    systemService = true;
    dataDir = "${config_dir}/Syncthing/data";
    configDir = "${config_dir}/Syncthing";
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
