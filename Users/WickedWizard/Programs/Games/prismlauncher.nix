{ pkgs, sources, ... }:
{
  home.packages = with pkgs; [ prismlauncher ];

  programs.nvfetcher.config.prismlauncher_catppuccin = {
    src.git = "https://github.com/catppuccin/prismlauncher.git";
    fetch.github = "catppuccin/prismlauncher";
  };

  # TODO: Try to convert this to a generic theme that can be used with Stylix.

  home.file.".local/share/PrismLauncher/themes/Mocha".source =
    "${sources.prismlauncher_catppuccin.src}/themes/Mocha";
}
