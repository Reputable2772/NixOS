{
  xdg.mimeApps.enable = true;
  programs.home-manager.enable = true;

  imports = [
    ./applications.nix
    ./flatpak.nix
  ];
}
