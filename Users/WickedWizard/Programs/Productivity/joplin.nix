{ pkgs, ... }: {
  home.packages = with pkgs; [
    joplin-desktop
  ];

  programs.autostart.packages = with pkgs; [ joplin-desktop ];
}
