{ config, pkgs, ... }: {
  imports = [
    ./Browsers
    ./Communication
    ./Media
    ./Shell
    ./bitwarden.nix
    ./git.nix
    ./gpg.nix
    ./flameshot.nix
    ./gnome.nix
    ./obsidian.nix
    ./spotify.nix
    ./kitty.nix
    ./vscode.nix
  ];
}
