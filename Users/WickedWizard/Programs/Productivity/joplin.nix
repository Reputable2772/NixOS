{ sources, ... }:
{
  # Convert to stylix as well
  services.flatpak.packages = [ "net.cozic.joplin_desktop" ];
  # programs.autostart.packages = with pkgs; [ joplin-desktop ];

  home.file = {
    ".var/app/net.cozic.joplin_desktop/.config/joplin-desktop/userchrome.css".source =
      "${sources.joplin_catppuccin.src}/src/mocha/userchrome.css";
    ".var/app/net.cozic.joplin_desktop/.config/joplin-desktop/userstyle.css".source =
      "${sources.joplin_catppuccin.src}/src/mocha/userstyle.css";
  };
}
