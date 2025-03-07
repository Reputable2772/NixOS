{ lib, ... }:
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

  # Forced due to this
  # https://github.com/Jas-SinghFSU/HyprPanel/blob/2be9f1ef6c2df2ecf0eebe5a039e8029d8d151cd/nix/module.nix#L639
  nixpkgs.overlays = lib.mkForce null;
}
