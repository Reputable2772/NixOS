{ config, pkgs, ... }: {
  imports = [
    ./direnv.nix
    ./nodejs.nix
    ./python.nix
    ./vscode.nix
  ];
}
