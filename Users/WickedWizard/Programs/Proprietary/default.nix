{ config, pkgs, ... }: {
  imports = [
    ./beeper.nix
    ./spotify.nix
    ./telegram.nix
    ./whatsapp.nix
  ];
}
