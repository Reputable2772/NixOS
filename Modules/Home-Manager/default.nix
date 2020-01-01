{ inputs, ... }:
{
  imports = [
    ./autostart.nix
    ./backup.nix
    ./flatpak-config.nix
    ./quadlets.nix
    ./shells.nix
    ./vscode.nix
    ./files.nix
  ];

  disabledModules = [
    "${inputs.home-manager}/modules/programs/vscode.nix"
    "${inputs.home-manager}/modules/files.nix"
  ];
}
