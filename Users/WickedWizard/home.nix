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
      force = true;
    };

  imports = [
    ./Programs
    ./Services

    ./flatpak.nix
    ./secrets.nix
  ];

  programs.home-manager.enable = true;
  programs.autostart.enable = true;

  # Fixes nix-community/home-manager#5552
  xdg.configFile."systemd/user/.hm-keep".text = "";
}
