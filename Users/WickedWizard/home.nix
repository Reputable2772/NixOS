{ config, pkgs, ... }: {
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

    ./secrets.nix
  ];

  programs.home-manager.enable = true;
  programs.autostart.enable = true;
  programs.firejail = {
    enable = false;
    # This is a necessary, since passing `config.home.packages` itself without modifying would cause an infinite recursion.
    packages = config.home.packages ++ [
      (pkgs.runCommand "a-dummy-package" { } ''
        mkdir -p $out
        touch $out/awesome
      '')
    ];
  };
}
