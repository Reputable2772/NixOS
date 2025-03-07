{ pkgs, sources, ... }:
{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vkcapture
    ];
  };

  xdg.configFile."obs-studio/themes/".source = "${sources.obs_catppuccin.src}/themes";
}
