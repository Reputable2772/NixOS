{ pkgs, ... }: {
  home.packages = with pkgs; [
    joplin
    joplin-desktop
  ];

  programs.autostart.autostartPackages = with pkgs; [ joplin-desktop ];
}
