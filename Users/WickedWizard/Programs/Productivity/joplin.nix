{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    joplin
    joplin-desktop
  ];

  xdg.configFile."autostart/joplin-desktop.desktop".source = "${pkgs.joplin-desktop}/share/applications/@joplinapp-desktop.desktop";
}
