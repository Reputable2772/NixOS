{ pkgs, sources, ... }:
{
  home.packages = with pkgs; [ prismlauncher ];

  home.file.".local/share/PrismLauncher/themes/Mocha".source =
    "${sources.prismlauncher_catppuccin.src}/themes/Mocha";
}
