{ sources, ... }:
{
  # Used in Syncthing and backup.

  # Convert to stylix as well
  services.flatpak.packages = [ "net.cozic.joplin_desktop" ];
  # programs.autostart.packages = with pkgs; [ joplin-desktop ];

  programs.nvfetcher.config.joplin_catppuccin = {
    src.git = "https://github.com/catppuccin/joplin.git";
    fetch.github = "catppuccin/joplin";
  };

  home.file = {
    ".var/app/net.cozic.joplin_desktop/.config/joplin-desktop/userchrome.css".source =
      "${sources.joplin_catppuccin.src}/src/mocha/userchrome.css";
    ".var/app/net.cozic.joplin_desktop/.config/joplin-desktop/userstyle.css".source =
      "${sources.joplin_catppuccin.src}/src/mocha/userstyle.css";
  };
}
