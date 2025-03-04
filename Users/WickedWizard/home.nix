{
  imports = [
    ./Programs
    ./Services

    ./stylix.nix
    ./flatpak.nix
    ./secrets.nix
  ];

  xdg.mimeApps.enable = true;
  programs.home-manager.enable = true;
  programs.autostart.enable = true;
}
