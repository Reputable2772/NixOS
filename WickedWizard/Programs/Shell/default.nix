{ config, pkgs, ... }: {
  imports = [
    ./autojump.nix
    ./bash.nix
    ./zsh.nix
    ./git.nix
    ./gpg.nix
  ];
}
