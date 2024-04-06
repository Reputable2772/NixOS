{ config, ... }: {
  # Shell script added for this purpose
  xdg.configFile.mimeapps = {
    enable = true;
    target = "mimeapps.list";
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/Config/mimeapps.list";
  };

  imports = [
    ./Programs
    ./Services

    ../../Modules/Home-Manager
  ];

  programs.home-manager.enable = true;
  programs.autostart.enable = true;
}
