{ config, pkgs, ... }: {
  imports = [
    ./autojump.nix
    ./bash.nix
    ./git.nix
    ./packages.nix
    ./zsh.nix
  ];
}
