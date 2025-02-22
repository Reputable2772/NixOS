{ inputs, ... }:
{
  imports = [
    ./autostart.nix
    ./backup.nix
    ./flatpak-config.nix
    ./quadlets.nix
    ./shells.nix
    ./files.nix
  ];

  disabledModules = [
    "${inputs.home-manager}/modules/files.nix"
  ];
}
