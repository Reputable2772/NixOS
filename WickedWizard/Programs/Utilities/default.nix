{ config, pkgs, ... }: {
  imports = [
    ./flameshot.nix
    ./kitty.nix
    ./vscode.nix
  ];
}
