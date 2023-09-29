{ config, pkgs, ... }: {
  imports = [
    ./beeper.nix
    # ./obsidian.nix
    ./spotify.nix
    ./telegram.nix
    ./whatsapp.nix
  ];
}
