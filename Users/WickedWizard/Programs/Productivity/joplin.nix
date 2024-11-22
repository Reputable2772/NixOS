{ pkgs, sources, ... }:
{
  home.packages = with pkgs; [ joplin-desktop ];

  # programs.autostart.packages = with pkgs; [ joplin-desktop ];

  xdg.configFile = {
    "joplin-desktop/userchrome.css".source = "${sources.joplin_catppuccin.src}/src/mocha/userchrome.css";
    "joplin-desktop/userstyle.css".source = "${sources.joplin_catppuccin.src}/src/mocha/userstyle.css";
  };
}
