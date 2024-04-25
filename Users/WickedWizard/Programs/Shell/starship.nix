{ pkgs, ... }:
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
    } // builtins.fromTOML (
      builtins.readFile (pkgs.fetchurl
        {
          url = "https://raw.githubusercontent.com/catppuccin/starship/main/palettes/mocha.toml";
          hash = "sha256-cSaZrSfbk97d2kV3q5dT924MgmUuY8eYIIU0PIygH5w=";
        }).outPath
    );
  };
}
