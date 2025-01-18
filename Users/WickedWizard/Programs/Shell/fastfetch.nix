{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fastfetch
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

  programs.shells.rcExtra = ''
    fastfetch
  '';

  xdg.configFile."fastfetch/config.jsonc".source = "${pkgs.fastfetch.src}/presets/examples/7.jsonc";
}
