{ pkgs, ... }:
let
  catppuccin = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/bottom/main/themes/mocha.toml";
    hash = "sha256-jdJPxArv7sq+LNSGNFJigDfoM9CROXzYUpnwqYfEUdI=";
  };
in
{
  programs.bottom = {
    enable = true;
    settings = {
      flags = {
        group_processes = true;
      };
    } // builtins.fromTOML (builtins.readFile catppuccin);
  };
}
