{ pkgs, sources, ... }:
{
  home.packages = with pkgs; [ nerdfonts ];

  programs.eza = {
    enable = true;
    colors = "auto";
    icons = "auto";
    git = true;
    options = [
      "--group-directories-first"
    ];
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  xdg.configFile."eza/theme.yml".source = "${sources.eza_themes.src}/themes/catppuccin.yml";
}
