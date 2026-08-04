{ pkgs, sources, ... }:
{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vkcapture
    ];
  };

  programs.nvfetcher.config.obs_catppuccin = {
    src.git = "https://github.com/catppuccin/obs.git";
    fetch.github = "catppuccin/obs";
  };

  xdg.configFile."obs-studio/themes/".source = "${sources.obs_catppuccin.src}/themes";
}
