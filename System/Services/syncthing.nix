## Only configure devices and folders here. Configure rest through web interface.

{ config, pkgs, ... }: {
  services.syncthing = {
    enable = true;
    user = "wickedwizard";
    systemService = true;
    dataDir = "/home/wickedwizard/Documents";
    configDir = "/home/wickedwizard/Documents/Config/Syncthing";
    settings = {
      devices = {
        "Redmi S2" = { id = "FVKBTJS-3KMPR7D-2CXVBPR-F5HUD5E-7E2KJAT-ZABMG6E-4RK3CK6-H5OOMQP"; };
      };
      folders = {
        "Aegis" = {
          path = "/home/wickedwizard/Documents/Aegis";
          devices = [ "Redmi S2" ];
        };
        "Books" = {
          path = "/home/wickedwizard/Documents/Books";
          devices = [ "Redmi S2" ];
        };
        "Important Files" = {
          path = "/home/wickedwizard/Documents/Important Files";
          devices = [ "Redmi S2" ];
        };
        "Magisk" = {
          path = "/home/wickedwizard/Documents/Magisk";
          devices = [ "Redmi S2" ];
        };
        "Joplin" = {
          path = "/home/wickedwizard/Documents/Joplin";
          devices = [ "Redmi S2" ];
        };
        "SIM Backup" = {
          path = "/home/wickedwizard/Documents/SIM Backup";
          devices = [ "Redmi S2" ];
        };
        "Signal" = {
          path = "/home/wickedwizard/Documents/Signal";
          devices = [ "Redmi S2" ];
        };
        "Study Materials" = {
          path = "/home/wickedwizard/Documents/Study Materials";
          devices = [ "Redmi S2" ];
        };
        "Torrents" = {
          path = "/home/wickedwizard/Documents/Torrents";
          devices = [ "Redmi S2" ];
        };
      };
    };
  };
}
