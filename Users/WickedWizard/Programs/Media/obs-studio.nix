{ pkgs, ... }:
let
  catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "obs";
    rev = "e7c4fcf387415a20cb747121bc0416c4c8ae3362";
    sha256 = "sha256-dZcgIPMa1AUFXcMPT99YUUhvxHbniv0Anbh9/DB00NY=";
  };
in
{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
    ];
  };

  xdg.configFile."obs-studio/themes/".source = "${catppuccin}/themes";
}
