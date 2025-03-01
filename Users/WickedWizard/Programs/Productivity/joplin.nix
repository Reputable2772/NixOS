{ sources, ... }:
{
  services.flatpak.packages = [ "net.cozic.joplin_desktop" ];
  # programs.autostart.packages = with pkgs; [ joplin-desktop ];

  home.file = {
    "joplin-desktop/userchrome.css".source =
      "${sources.joplin_catppuccin.src}/src/mocha/userchrome.css";
    "joplin-desktop/userstyle.css".source = "${sources.joplin_catppuccin.src}/src/mocha/userstyle.css";
  };
}
