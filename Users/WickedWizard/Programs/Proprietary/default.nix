{ config, pkgs, ... }: {
  imports = [
    ./armcord.nix
    ./beeper.nix
    ./spotify.nix
    ./telegram.nix
    ./whatsapp.nix
  ];
}
