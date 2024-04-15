{ config, ... }: {
  # Shell script added for this purpose
  xdg.configFile.mimeapps =
    let
      file = ../../Config/mimeapps.list;
    in
    {
      enable = builtins.pathExists file;
      target = "mimeapps.list";
      source = config.lib.file.mkOutOfStoreSymlink file;
    };

  imports = [
    ./Programs
    ./Services

    ../../Modules/Home-Manager
  ];

  programs.home-manager.enable = true;
  programs.autostart.enable = true;
}
