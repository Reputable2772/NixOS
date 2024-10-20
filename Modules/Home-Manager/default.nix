{ inputs, ... }: {
  imports = [
    ./autostart.nix
    ./backup.nix
    ./quadlets.nix
    ./shells.nix
    ./vscode.nix
  ];

  disabledModules = [ "${inputs.home-manager}/modules/programs/vscode.nix" ];
}
