{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Should pickup theme from terminal itself.
  programs.eza = {
    enable = true;
    colors = "auto";
    icons = "auto";
    git = true;
    extraOptions = [
      "--group-directories-first"
      "--all"
      "-l"
    ];
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  # programs.nvfetcher.eza_themes = {
  #   src.git = "https://github.com/eza-community/eza-themes.git";
  #   fetch.github = "eza-community/eza-themes";
  # };

  # xdg.configFile."eza/theme.yml".source = "${sources.eza_themes.src}/themes/catppuccin.yml";
}
