{ pkgs, ... }: {
  home.packages = with pkgs; [ schildichat-desktop ];

  # programs.autostart.autostartPackages = with pkgs; [ schildichat-desktop ];
}
