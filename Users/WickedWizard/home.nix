{
  imports = [
    ./Programs
    ./Services

    ./flatpak.nix
    ./secrets.nix
  ];

  xdg.mimeApps.enable = true;
  programs.home-manager.enable = true;
  programs.autostart.enable = true;

  # Fixes nix-community/home-manager#5552
  xdg.configFile."systemd/user/.hm-keep".text = "";
}
