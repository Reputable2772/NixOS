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

  # xdg.configFile."eza/theme.yml".source = "${sources.eza_themes.src}/themes/catppuccin.yml";
}
