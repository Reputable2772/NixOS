{
  xdg.mimeApps.enable = true;
  programs.home-manager.enable = true;

  imports = [
    ./flatpak.nix
  ];
}
