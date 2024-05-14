{ pkgs, ... }: {
  home.packages = with pkgs; [
    joplin
    joplin-desktop
  ];

  programs.autostart.packages = with pkgs; [ joplin-desktop ];
}
