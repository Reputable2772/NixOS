{ sources, ... }:
let
  flavour = "mocha";
in
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      palette = "catppuccin_${flavour}";
    } // builtins.fromTOML (builtins.readFile "${sources.starship_catppuccin.src}/palettes/${flavour}.toml");
  };
}
