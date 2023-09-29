{ config, pkgs, ... }: {
  imports = [
    ./direnv.nix
    ./vscode.nix
  ];
}
